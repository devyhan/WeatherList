//
//  FiveDaysWeather.swift
//  Domain
//
//  Created by 조요한 on 2022/09/26.
//

import Foundation

public struct FiveDaysWeather: Equatable {
  public let city: String
  public let weather: [Weather]
  
  public init(
    city: String,
    weather: [Weather]
  ) {
    self.city = city
    self.weather = weather
  }
}

public struct Weather: Equatable {
  public let icon: String
  public let status: String
  public let teempMax: Double
  public let teempMin: Double
  public let date: Date?
  
  public init(
    icon: String,
    status: String,
    teempMax: Double,
    teempMin: Double,
    date: Date?
  ) {
    self.icon = icon
    self.status = status
    self.teempMax = teempMax
    self.teempMin = teempMin
    self.date = date
  }
}
