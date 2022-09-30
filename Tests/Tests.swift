//
//  Tests.swift
//  Tests
//
//  Created by 조요한 on 2022/09/23.
//

import Container
import Domain
import Nimble
import Presentation
import RxCocoa
import RxSwift
import RxNimble
import RxTest
import XCTest
@testable import WeatherList

final class Tests: XCTestCase {
  var injected: DependencyInjection?
  var disposeBag: DisposeBag?
  var scheduler: TestScheduler?
  var viewModel: WeatherListVM?
  var viewDidLoad: PublishSubject<Void>?
  var refreshControlAction: PublishSubject<Void>?
  var output: WeatherListVM.Output?
  
  // Given
  override func setUp() {
    injected = DependencyInjection.assembly
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
    viewModel = WeatherListVM()
    viewDidLoad = PublishSubject<Void>()
    refreshControlAction = PublishSubject<Void>()
    
    if let viewModel = viewModel, let refreshControlAction = refreshControlAction, let viewDidLoad = viewDidLoad {
      output = viewModel.transform(
        input: .init(
          viewDidLoad: viewDidLoad,
          refreshControlAction: refreshControlAction
        )
      )
    }
  }
  
  // viewDidLoad가 트리거 될 경우, 데이터가 generateObject()에 의해 잘 생성 되는지 검증합니다.
  func test_viewDidLoad() {
    guard
      let viewDidLoad = viewDidLoad, let viewModel = viewModel, let scheduler = scheduler, let output = output, let disposeBag = disposeBag,
      let testCurrentDate = "2022-09-27".toDate(dateFormat: "yyyy-MM-dd")
    else { return }
    
    let mockSectionWeatherDate = [
      SectionWeatherData(
        header: "Seoul",
        items: [
          Weather(icon: "01d", status: "Clear", teempMax: 301.18, teempMin: 299.04, date: "2022-09-27 06:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "02n", status: "Clouds", teempMax: 293.89, teempMin: 293.89, date: "2022-09-27 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "04n", status: "Clouds", teempMax: 293.18, teempMin: 293.18, date: "2022-09-28 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "01n", status: "Clear", teempMax: 292.96, teempMin: 292.96, date: "2022-09-29 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "04n", status: "Clouds", teempMax: 293.6, teempMin: 293.6, date: "2022-09-30 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ss Z")),
          Weather(icon: "04n", status: "Clouds", teempMax: 293.65, teempMin: 293.65, date: "2022-10-01 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ"))
        ]
      ),
      SectionWeatherData(
        header: "London",
        items: [
          Weather(icon: "10n", status: "Rain", teempMax: 282.94, teempMin: 282.19, date: "2022-09-27 06:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ss Z")),
          Weather(icon: "04d", status: "Clouds", teempMax: 286.31, teempMin: 286.31, date: "2022-09-27 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "04d", status: "Clouds", teempMax: 284.88, teempMin: 284.88, date: "2022-09-28 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "01d", status: "Clear", teempMax: 287.14, teempMin: 287.14, date: "2022-09-29 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "01d", status: "Clear", teempMax: 287.79, teempMin: 287.79, date: "2022-09-30 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "04d", status: "Clouds", teempMax: 288.94, teempMin: 288.94, date: "2022-10-01 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ"))
        ]
      ),
      SectionWeatherData(
        header: "Chicago",
        items: [
          Weather(icon: "03n", status: "Clouds", teempMax: 285.36, teempMin: 284.77, date: "2022-09-27 06:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "04d", status: "Clouds", teempMax: 284.53, teempMin: 284.53, date: "2022-09-27 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "03d", status: "Clouds", teempMax: 285.69, teempMin: 285.69, date: "2022-09-28 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "02d", status: "Clouds", teempMax: 287.4, teempMin: 287.4, date: "2022-09-29 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "01d", status: "Clear", teempMax: 288.6, teempMin: 288.6, date: "2022-09-30 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ")),
          Weather(icon: "01d", status: "Clear", teempMax: 290.19, teempMin: 290.19, date: "2022-10-01 15:00:00 +0000".toDate(dateFormat: "yyyy-MM-dd HH:mm:ssZ"))
        ]
      )
    ]
    
    // When
    viewModel.currentDate = testCurrentDate
    scheduler.createColdObservable(
      [.next(1, ())]
    )
    .bind(to: viewDidLoad)
    .disposed(by: disposeBag)
    
    //Then
    expect(output.weatherList)
      .events(scheduler: scheduler, disposeBag: disposeBag)
      .to(
        equal(
          [
            .next(0, []),
            .next(1, mockSectionWeatherDate)
          ]
        )
      )
  }
  
  // 리프레쉬 액션이 들어왔을 경우, 로딩 스피너의 상태가 제대로 변경 되는지 검증합니다.
  func test_refreshControlAction() {
    guard let refreshControlAction = refreshControlAction, let scheduler = scheduler, let output = output, let disposeBag = disposeBag else { return }
    
    // When
    scheduler.createColdObservable(
      [.next(1, ())]
    )
    .bind(to: refreshControlAction)
    .disposed(by: disposeBag)
    
    // Then
    expect(output.isLoadingSpinnerAvaliable)
      .events(scheduler: scheduler, disposeBag: disposeBag)
      .to(equal([
        .next(0, false),
        .next(1, true),
        .next(1, false)
      ]))
  }
}
