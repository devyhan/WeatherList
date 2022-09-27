//
//  MockFetchWeatherList.swift
//  Data
//
//  Created by 조요한 on 2022/09/27.
//

import Domain
import Infrastructure
import RxSwift

public final class MockFetchWeatherList: FetchWeatherList {
  private let mockClient: MockClient
  private let translator: FetchWeatherListTranslatorType = FetchWeatherListTranslator()
  
  public init(mockClient: MockClient) {
    self.mockClient = mockClient
  }
  
  public func execute(city: String) -> Observable<FiveDaysWeather> {
    let element = mockClient
      .buildMock
      .execute(FiveDaysWeatherDTO.self, from: "\(city)FiveDays")
      .map {
        self.translator.execute($0)
      }
    
    return Observable.just(element ?? FiveDaysWeather(city: "", weather: []))
  }
}
