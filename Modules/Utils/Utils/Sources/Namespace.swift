//
//  Namespace.swift
//  Utils
//
//  Created by YHAN on 2022/09/29.
//

import Foundation

public enum Colors: String {
  case backgroundReverse = "background.reverse"
  
  var color: UIColor {
    return UIColor(named: self.rawValue) ?? .clear
  }
}

