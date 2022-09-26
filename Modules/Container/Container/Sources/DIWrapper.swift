//
//  DIWrapper.swift
//  WeatherList
//
//  Created by 조요한 on 2022/09/26.
//

import Foundation

public protocol Injectable {}

@propertyWrapper
public struct Injected<T: Injectable> {
  public let wrappedValue: T
  
  public init() {
    wrappedValue = Resolver.shared.resolve()
  }
}

public final class Resolver {
  
  private var storage = [String: Injectable]()
  
  public static let shared = Resolver()
  public init() {}
  
  public func register<T: Injectable>(_ injectable: T) {
    let key = String(reflecting: injectable)
    storage[key] = injectable
  }
  
  public func resolve<T: Injectable>() -> T {
    let key = String(reflecting: T.self)
    
    guard let injectable = storage[key] as? T else {
      fatalError("\(key)를 Injactable 가능한 DIContainor에 추가 해주세요.")
    }
    
    return injectable
  }
}
