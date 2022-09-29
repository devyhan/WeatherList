//
//  Extension.swift
//  Utils
//
//  Created by YHAN on 2022/09/26.
//

import Foundation

// MARK: - String

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

// MARK: - Date

public extension Date {
  func toString(dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: self)
  }
  
  var toLocalizedRelativeDate: String {
    let date = DateFormatter()
    date.locale = Locale(identifier: Locale.current.identifier)
    date.dateStyle = .full
    // 오늘, 내일 만 상대날짜로 변경
    if Date()...Date().addingTimeInterval(3600 * 24) ~= self {
      date.doesRelativeDateFormatting = true
    } else {
      date.setLocalizedDateFormatFromTemplate("E d MMM")
    }
    return date.string(from: self)
  }
}

// MARK: - ProcessInfo

public extension ProcessInfo {
  var isRunningForTests: Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
  }
}

// MARK: - Locale

public extension Locale {
  var temperatureUnit: UnitTemperature {
    let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    let measurement = Measurement(value: 37, unit: UnitTemperature.celsius)
    let temperatureString = MeasurementFormatter().string(from: measurement)
    let matchedUnit = units.first { temperatureString.contains($0.symbol) }
    if matchedUnit != nil {
      return matchedUnit!
    }
    return usesMetricSystem ? .celsius : .fahrenheit
  }
  
  var currentDeviceLanguage: String {
    let preferredLanguages = Locale.preferredLanguages.first
    let preferredLanguage = preferredLanguages?.components(separatedBy: "-")
    let language = preferredLanguage?.last?.lowercased() ?? "en"
    
    return language
  }
}

// MARK: - UIWindow

import UIKit

public extension UIWindow {
  
  var visibleViewController: UIViewController? {
    return self.visibleViewControllerFrom(vc: self.rootViewController)
  }
  
  func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nc = vc as? UINavigationController {
      return self.visibleViewControllerFrom(vc: nc.visibleViewController)
    } else if let tc = vc as? UITabBarController {
      return self.visibleViewControllerFrom(vc: tc.selectedViewController)
    } else {
      if let pvc = vc?.presentedViewController {
        return self.visibleViewControllerFrom(vc: pvc)
      } else {
        return vc
      }
    }
  }
}

// MARK: - UIColor

public extension UIColor {
  convenience init?(assetName: Colors) {
    self.init(named: assetName.rawValue)
  }
}
