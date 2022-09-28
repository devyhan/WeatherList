//
//  CombinedComponent.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

struct CombinedComponent: URLComponent {
  private let children: [URLComponent]
  
  init(_ children: [URLComponent]) {
    self.children = children
  }
  
  func build(_ urlComponents: inout URLComponents) {
    children.forEach {
      $0.build(&urlComponents)
    }
  }
}
