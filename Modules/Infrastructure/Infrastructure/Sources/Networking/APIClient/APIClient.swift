//
//  APIClient.swift
//  Infrastructure
//
//  Created by ์กฐ์ํ on 2022/09/26.
//

import Foundation

public protocol APIClient {
  func buildRequest(url: URL?) -> RequestBuilder
}

public final class APIClientImpl: APIClient {
  
  public init() {}
  
  public func buildRequest(url: URL?) -> RequestBuilder {
    let url: URL = {
      guard let url = url else { return URL(string: "")! }
      return url
    }()
    let requestURL = URLRequest(url: url)
    
    return RequestBuilderImpl(url: requestURL)
  }
}
