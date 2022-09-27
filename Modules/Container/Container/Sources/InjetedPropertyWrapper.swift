//
//  InjetedPropertyWrapper.swift
//  WeatherList
//
//  Created by 조요한 on 2022/09/26.
//

import Foundation
import Domain

@propertyWrapper
public struct Injected<T> {
  
  private let keyPath: KeyPath<DependencyInjection, T>
  
  public var wrappedValue: T {
    DependencyInjection.assembly[keyPath: keyPath]
  }
  
  public init(_ keyPath: KeyPath<DependencyInjection, T>) {
    self.keyPath = keyPath
  }
}
