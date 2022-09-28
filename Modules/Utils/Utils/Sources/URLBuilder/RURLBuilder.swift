//
//  RURLBuilder.swift
//  Utils
//
//  Created by YHAN on 2022/09/28.
//

import Foundation

@resultBuilder
public struct RURLBuilder {
  public static func buildBlock(_ components: URLComponent...) -> URLComponent {
    CombinedComponent(components)
  }
  
  public static func buildExpression(_ expression: URLComponent) -> URLComponent {
    expression
  }
  
  public static func buildExpression(_ staticString: StaticString) -> URL? {
    return URL(string: "\(staticString)")
  }
  
  public static func buildOptional(_ component: URLComponent?) -> URLComponent {
    component ?? EmptyComponent()
  }
  
  public static func buildEither(first: URLComponent) -> URLComponent {
    first
  }
  
  public static func buildEither(second: URLComponent) -> URLComponent {
    second
  }
  
  public static func buildArray(_ components: [URLComponent]) -> URLComponent {
    CombinedComponent(components)
  }
}

public extension URL {
  init?(@RURLBuilder _ build: () -> URLComponent) {
    let combinedComponent = build()
    var urlComponents = URLComponents()
    combinedComponent.build(&urlComponents)
    
    if let url = urlComponents.url {
      self = url
    } else {
      return nil
    }
  }
}
