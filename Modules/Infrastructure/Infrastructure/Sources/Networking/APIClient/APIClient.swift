//
//  APIClient.swift
//  Infrastructure
//
//  Created by 조요한 on 2022/09/26.
//

import Foundation

public protocol APIClient {
  func buildRequest(url: String) -> RequestBuilder
}

public final class APIClientImpl: APIClient {
  
  public init() {}
  
  public func buildRequest(url: String) -> RequestBuilder {
    let url: URL = {
      guard let url = URL(string: url) else { return URL(string: "")! }
      return url
    }()
    let requestURL = URLRequest(url: url)
    
    return RequestBuilderImpl(url: requestURL)
  }
}
