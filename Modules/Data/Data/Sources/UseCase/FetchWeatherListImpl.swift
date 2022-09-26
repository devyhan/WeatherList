//
//  FetchWeatherListImpl.swift
//  Data
//
//  Created by YHAN on 2022/09/25.
//

import Domain
import Infrastructure
import RxSwift

public final class FetchWeatherListImpl: FetchWeatherList {
  private let apiClient: APIClient
  private let getSecrets: GetSecrets
  
  public init(
    apiClient: APIClient,
    getSecrets: GetSecrets
  ) {
    self.apiClient = apiClient
    self.getSecrets = getSecrets
  }
  
  public func execute(city: String) -> Observable<FiveDaysWeather> {
    let baseUrl = getSecrets.execute(secretKey: "BASE_URL")
    let apiKey = getSecrets.execute(secretKey: "API_KEY")
    let url = "\(baseUrl)/data/2.5/forecast?q=London&appid=\(apiKey)"
    
    return apiClient
      .buildRequest(url: url)
      .add(method: .post)
      .execute()
      .map { data in
        guard
          let response = try? JSONDecoder().decode(FiveDaysWeatherDTO.self, from: data)
        else { throw NSError(domain: "Decoding error", code: -1, userInfo: nil) }
        return response
      }
      .map { self.translate($0) }
  }
}


// 386e1bc19028d0b571ae5369d42e5ccc
