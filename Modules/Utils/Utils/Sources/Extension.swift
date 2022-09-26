//
//  Extension.swift
//  Utils
//
//  Created by YHAN on 2022/09/26.
//

import Foundation

public extension String {
  func toDate(dateFormat: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    if let date = dateFormatter.date(from: self) {
      return date
    } else {
      return nil
    }
  }
}
