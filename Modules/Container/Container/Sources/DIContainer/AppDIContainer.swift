//
//  AppDIContainer.swift
//  WeatherList
//
//  Created by 조요한 on 2022/09/26.
//

import Data
import Domain
import Infrastructure

public final class DependencyInjection {
  public let repository: RepositoryInjectionType
  
  public init(repository: RepositoryInjectionType) {
    self.repository = repository
  }
}

public protocol RepositoryInjectionType {
  var sampleDomain: SampleDomain { get }
  var fetchWeatherList: FetchWeatherList { get }
}

public final class RepositoryInjection: RepositoryInjectionType {
  lazy private(set) public var sampleDomain: SampleDomain = SampleDomainImpl()
  lazy private(set) public var fetchWeatherList: FetchWeatherList = FetchWeatherListImpl(apiClient: APIClientImpl(), getSecrets: GetSecretsImpl())
  
  public init() { }
}

public final class MockRepositoryInjection: RepositoryInjectionType {
  lazy private(set) public var sampleDomain: SampleDomain = MockSampleDomain()
  lazy private(set) public var fetchWeatherList: FetchWeatherList = MockFetchWeatherList(mockClient: MockClientImpl())
  
  public init() { }
}

public extension DependencyInjection {
  // register하는 대신 static을 활용한다.
  static var assembly: DependencyInjection = {
    if ProcessInfo.processInfo.isRunningForTests {
      // Unit test에서는 네트워크 의존을 제거하여아 네트워크 모듈에 의한 사이드 이팩트가 안생기기 떄문에 Mock Oject를 주입한다.
      return DependencyInjection(
        repository: MockRepositoryInjection()
      )
    } else {
      return DependencyInjection(
        repository: RepositoryInjection()
      )
    }
  }()
}

extension ProcessInfo {
  var isRunningForTests: Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
  }
}

// MARK: - Sample

public protocol SampleDomain: Injectable {
  func execute() -> String
}

public final class SampleDomainImpl: SampleDomain {
  public init() {}
  
  public func execute() -> String {
    "Injected SampleDependency"
  }
}

public final class MockSampleDomain: SampleDomain {
  public init() {}
  
  public func execute() -> String {
    "Injected Mock SampleDependency"
  }
}
