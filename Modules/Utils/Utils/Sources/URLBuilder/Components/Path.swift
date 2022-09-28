//
//  Path.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

public struct Path: URLComponent {
  private var path: String
  
  public init(_ path: String) {
    if !path.hasPrefix("/") {
      self.path = "/" + path
    } else {
      self.path = path
    }
  }
  
  public func build(_ urlComponents: inout URLComponents) {
    urlComponents.path += path
  }
}
