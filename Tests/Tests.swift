//
//  Tests.swift
//  Tests
//
//  Created by 이재원 on 2022/09/23.
//

import Container
import XCTest
import RxSwift
import RxCocoa
import RxNimble
import Nimble
import RxTest
@testable import WeatherList

final class Tests: XCTestCase {
  var injected: DependencyInjection?

  // Given
  override func setUp() {
    injected = DependencyInjection.assembly
  }
  
  func test_sample() {
    // When
    guard let injectedString = injected?.repository.sampleDomain.execute() else { return }
    
    // Then
    XCTAssertEqual("Injected Mock SampleDependency", injectedString)
  }
  
  func test_fetchWeatherList() {
    guard let injected else { return }
    
    let fetchSeoulData = injected.repository.fetchWeatherList.execute(city: "Seoul")
    dump(fetchSeoulData)
    
    let fetchLondonData = injected.repository.fetchWeatherList.execute(city: "London")
    dump(fetchLondonData)
    
    let fetchChicagoData = injected.repository.fetchWeatherList.execute(city: "Chicago")
    dump(fetchChicagoData)
  }
}
