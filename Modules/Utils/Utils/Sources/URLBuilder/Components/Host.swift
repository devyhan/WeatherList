//
//  Host.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

public struct Host: URLComponent {
  private let host: String
  
  public init(_ host: String) {
    self.host = host
  }
  
  public func build(_ urlComponents: inout URLComponents) {
    urlComponents.host = host
  }
}
