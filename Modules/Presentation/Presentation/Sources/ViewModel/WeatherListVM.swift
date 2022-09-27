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
  private let items = BehaviorRelay<[FiveDaysWeather]>(value: [])
  private let refreshControlCompelted = BehaviorRelay<Void>(value: ())
  private let isLoadingSpinnerAvaliable = BehaviorRelay<Bool>(value: false)
  
  public struct Input {
    let refreshControlAction: Observable<Void>
    
    public init(refreshControlAction: Observable<Void>) {
      self.refreshControlAction = refreshControlAction
    }
  }
  
  public struct Output {
    let weatherList: Driver<[FiveDaysWeather]>
    let refreshControlCompelted: Driver<Void>
    public let isLoadingSpinnerAvaliable: Driver<Bool>
    
    public init(
      weatherList: Driver<[FiveDaysWeather]>,
      refreshControlCompelted: Driver<Void>,
      isLoadingSpinnerAvaliable: Driver<Bool>
    ) {
      self.weatherList = weatherList
      self.refreshControlCompelted = refreshControlCompelted
      self.isLoadingSpinnerAvaliable = isLoadingSpinnerAvaliable
    }
  }
  
  public init() {
    fetchData()
  }
  
  public func transform(input: Input) -> Output {
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
    
    fetchWeatherList.execute(city: "Seoul")
      .subscribe { [weak self] data in
        guard let self = self else { return }
        print("weathers:", data)
        self.pickOutObject(with: data)
        self.isLoadingSpinnerAvaliable.accept(false)
      }
      .disposed(by: disposeBag)
  }
  
  private func pickOutObject(with object: FiveDaysWeather) {
    let weathers = object.weather
    
    var weatherArray: [Weather] = []
    for i in 0..<6 {
      let now = Calendar.current.date(byAdding: .day, value: i, to: Date())?.toString(dateFormat: "yyyy-MM-dd")
      if let weather = weathers.filter({ now == $0.date?.toString(dateFormat: "yyyy-MM-dd") }).first {
        weatherArray.append(weather)
      }
    }
  }
  
  private func refreshControlTriggered() {
    items.accept([])
    fetchData()
  }
}
