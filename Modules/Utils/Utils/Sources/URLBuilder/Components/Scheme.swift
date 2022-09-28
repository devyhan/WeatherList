//
//  Scheme.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

public struct Scheme: URLComponent {
  public enum `Type` {
    case http
    case https
    case custom(String)
    
    var rawValue: String {
      switch self {
      case .http:
        return "http"
      case .https:
        return "https"
      case .custom(let scheme):
        return scheme
      }
    }
  }
  
  private let schemeType: `Type`
  
  public init(_ type: `Type`) {
    schemeType = type
  }
  
  public func build(_ urlComponents: inout URLComponents) {
    urlComponents.scheme = schemeType.rawValue
  }
}
