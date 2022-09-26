//
//  FiveDaysWeatherDTO.swift
//  Data
//
//  Created by 조요한 on 2022/09/26.
//

import Foundation

struct FiveDaysWeatherDTO: Codable {
  let cod: String
  let message, cnt: Int
  let list: [ListDTO]
  let city: CityDTO
}

struct ListDTO: Codable {
  let dt: Int
  let main: MainDTO
  let weather: [WeatherDTO]
  let clouds: CloudsDTO
  let wind: WindDTO
  let visibility: Int
  let pop: Double
  let sys: SysDTO
  let dtTxt: String
  
  enum CodingKeys: String, CodingKey {
    case dt, main, weather, clouds, wind, visibility, pop, sys
    case dtTxt = "dt_txt"
  }
}

struct CityDTO: Codable {
  let id: Int
  let name: String
  let coord: CoordDTO
  let country: String
  let population, timezone, sunrise, sunset: Int
}

struct CoordDTO: Codable {
  let lat, lon: Double
}

struct CloudsDTO: Codable {
  let all: Int
}

struct MainDTO: Codable {
  let temp, feelsLike, tempMin, tempMax: Double
  let pressure, seaLevel, grndLevel, humidity: Int
  let tempKf: Double
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case seaLevel = "sea_level"
    case grndLevel = "grnd_level"
    case humidity
    case tempKf = "temp_kf"
  }
}

struct SysDTO: Codable {
  let pod: String
}

struct WeatherDTO: Codable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}

struct WindDTO: Codable {
  let speed: Double
  let deg: Int
  let gust: Double
}
