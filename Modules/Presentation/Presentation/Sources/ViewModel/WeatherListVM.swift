//
//  WeatherListVM.swift
//  Presentation
//
//  Created by 조요한 on 2022/09/27.
//

import Container
import Domain
import RxCocoa
import RxSwift

public protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}

public final class WeatherListVM: ViewModelType {
  @Injected(\.repository.fetchWeatherList) private var fetchWeatherList
  
  private let disposeBag = DisposeBag()
  private let items = BehaviorRelay<[SectionWeatherData]>(value: [])
  private let refreshControlCompelted = BehaviorRelay<Void>(value: ())
  private let isLoadingSpinnerAvaliable = BehaviorRelay<Bool>(value: false)
  public var currentDate = Date()
  
  public struct Input {
    let viewDidLoad: Observable<Void>
    let refreshControlAction: Observable<Void>
    
    public init(
      viewDidLoad: Observable<Void>,
      refreshControlAction: Observable<Void>
    ) {
      self.viewDidLoad = viewDidLoad
      self.refreshControlAction = refreshControlAction
    }
  }
  
  public struct Output {
    public let weatherList: Driver<[SectionWeatherData]>
    let refreshControlCompelted: Driver<Void>
    public let isLoadingSpinnerAvaliable: Driver<Bool>
    
    public init(
      weatherList: Driver<[SectionWeatherData]>,
      refreshControlCompelted: Driver<Void>,
      isLoadingSpinnerAvaliable: Driver<Bool>
    ) {
      self.weatherList = weatherList
      self.refreshControlCompelted = refreshControlCompelted
      self.isLoadingSpinnerAvaliable = isLoadingSpinnerAvaliable
    }
  }
  
  public init() {}
  
  public func transform(input: Input) -> Output {
    input.viewDidLoad
      .subscribe { [weak self] _ in
        guard let self = self else { return }
        self.fetchData()
      }
      .disposed(by: disposeBag)
    
    input.refreshControlAction
      .subscribe { [weak self] _ in
        guard let self = self else { return }
        self.refreshControlTriggered()
      }
      .disposed(by: disposeBag)
    
    return Output(
      weatherList: items.asDriver(onErrorJustReturn: []),
      refreshControlCompelted: refreshControlCompelted.asDriver(),
      isLoadingSpinnerAvaliable: isLoadingSpinnerAvaliable.asDriver()
    )
  }
  
  private func fetchData() {
    isLoadingSpinnerAvaliable.accept(true)
    
    let fetchSeoul = fetchWeatherList.execute(city: "Seoul")
    let fetchLondon = fetchWeatherList.execute(city: "London")
    let fetchChicago = fetchWeatherList.execute(city: "Chicago")
    
    Observable
      .combineLatest(fetchSeoul, fetchLondon, fetchChicago)
      .subscribe { [weak self] seoulData, LondonData, chicagoData in
        guard let self = self else { return }
        var value = self.items.value
        value.append(self.generateObject(header: seoulData.city, weathers: seoulData))
        value.append(self.generateObject(header: LondonData.city, weathers: LondonData))
        value.append(self.generateObject(header: chicagoData.city, weathers: chicagoData))

        self.items.accept(value)
        
        self.refreshControlCompelted.accept(())
        self.isLoadingSpinnerAvaliable.accept(false)
      }
      .disposed(by: disposeBag)
  }
  
  private func generateObject(header: String, weathers: FiveDaysWeather) -> SectionWeatherData {
    let weathers = weathers.weather
    
    var dayFirstTimeWeathers: [Weather] = []
    for i in 0..<6 {
      let now = Calendar.current.date(byAdding: .day, value: i, to: currentDate)
      
      if let weather = weathers.filter({ now?.toString(dateFormat: "yyyy-MM-dd") == Calendar.current.date(byAdding: .day, value: 0, to: $0.date ?? Date())?.toString(dateFormat: "yyyy-MM-dd") }).first {
        dayFirstTimeWeathers.append(weather)
      }
    }
    return SectionWeatherData(header: header, items: dayFirstTimeWeathers)
  }
  
  private func refreshControlTriggered() {
    items.accept([])
    fetchData()
  }
}
