//
//  AppDIContainer.swift
//  WeatherList
//
//  Created by 조요한 on 2022/09/26.
//

import Container
import Data
import Domain
import Infrastructure

final class DIContainer {
  let sampleDependency: SampleProtocol
  let fetchWeatherList: FetchWeatherList
  
  init() {
    self.sampleDependency = SampleDependency()
    self.fetchWeatherList = FetchWeatherListImpl(apiClient: APIClientImpl(), getSecrets: GetSecretsImpl())
    setDependencies()
  }
  
  private func setDependencies() {
    let resolver = Resolver.shared
    resolver.register(sampleDependency)
    resolver.register(fetchWeatherList)
  }
}

protocol SampleProtocol: Injectable {
  func execute() -> String
}

final class SampleDependency: SampleProtocol {
  func execute() -> String {
    "Injected SampleDependency"
  }
}
