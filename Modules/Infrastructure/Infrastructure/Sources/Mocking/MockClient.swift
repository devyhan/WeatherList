//
//  MockClient.swift
//  Infrastructure
//
//  Created by ์กฐ์ํ on 2022/09/27.
//

import RxSwift

public protocol MockBuilder {
  func execute<D: Codable>(_ type: D.Type, from resourceName: String) -> D?
}

public final class MockBuilderImpl: MockBuilder {
  public func execute<D: Codable>(_ type: D.Type, from resourceName: String) -> D? {
    guard
      let path = Bundle.main.path(forResource: resourceName, ofType: "json"),
      let jsonString = try? String(contentsOfFile: path)
    else {
      return nil
    }
    
    let decoder = JSONDecoder()
    let data = jsonString.data(using: .utf8)
    
    guard let data = data else { return nil }
    return try? decoder.decode(type, from: data)
  }
}

public protocol MockClient {
  var buildMock: MockBuilder { get }
}

public final class MockClientImpl: MockClient {
  
  public init() {
    setTestingTimeZone()
  }

  public var buildMock: MockBuilder {
    return MockBuilderImpl()
  }
  
  private func setTestingTimeZone() {
    guard let timeZone = TimeZone(identifier: "Asia/Seoul") else { return }
    TimeZone.ReferenceType.default = timeZone
    TimeZone.ReferenceType.resetSystemTimeZone()
  }
}
