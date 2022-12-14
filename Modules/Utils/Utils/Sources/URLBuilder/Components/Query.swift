//
//  Query.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

public struct Query: URLComponent {
  private var queryPrameters: [String: Any] = [:]
  
  public init(query name: String, value: Any? = nil) {
    queryPrameters[name] = value
  }
  
  public init(queryPrameters other: [String: Any]) {
    self.queryPrameters.merge(other) { (current, _) in current }
  }
  
  public func build(_ urlComponents: inout URLComponents) {
    urlComponents.queryItems = queryPrameters.map { URLQueryItem(name: $0.0, value: String(describing: $0.1)) }
  }
}
