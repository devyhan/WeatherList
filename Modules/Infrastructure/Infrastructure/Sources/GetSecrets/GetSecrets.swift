//
//  GetSecrets.swift
//  Infrastructure
//
//  Created by YHAN on 2022/09/26.
//

import Foundation

public protocol GetSecrets {
  func execute(secretKey: String) -> String
}

public final class GetSecretsImpl: GetSecrets {
  
  public init() {}
  
  public func execute(secretKey: String) -> String {
    guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"), let dictionary = NSDictionary(contentsOf: url), let result = dictionary[secretKey] as? String else { return String() }
    
    return result
  }
}
