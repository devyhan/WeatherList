//
//  EmptyComponent.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

struct EmptyComponent: URLComponent {
  func build(_ urlComponents: inout URLComponents) {
    // No op
  }
}
