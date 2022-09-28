//
//  URLComponent.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

public protocol URLComponent {
  func build(_ urlComponents: inout URLComponents)
}
