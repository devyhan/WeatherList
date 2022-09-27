//
//  Tests.swift
//  Tests
//
//  Created by 조요한 on 2022/09/23.
//

import Container
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
  var refreshControlAction: PublishSubject<Void>?
  var output: WeatherListVM.Output?

  // Given
  override func setUp() {
    injected = DependencyInjection.assembly
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
    viewModel = WeatherListVM()
    refreshControlAction = PublishSubject<Void>()
    
    if let viewModel, let refreshControlAction {
      output = viewModel.transform(
        input: .init(refreshControlAction: refreshControlAction)
      )
    }
  }

  // 리프레쉬 액션이 들어왔을 경우, 로딩 스피너의 상태가 제대로 변경 되는지 검증합니다.
  func test_refreshControlAction() {
    guard let refreshControlAction, let scheduler, let output, let disposeBag else { return }
    
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
        .next(1, false),
        .next(1, false)
      ]))
  }
  
  
}
