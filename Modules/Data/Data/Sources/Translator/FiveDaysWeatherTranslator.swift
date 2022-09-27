//
//  FiveDaysWeatherTranslator.swift
//  Data
//
//  Created by 조요한 on 2022/09/26.
//

import Domain
import Utils

protocol FetchWeatherListTranslatorType {
  func execute(_ dto: FiveDaysWeatherDTO) -> FiveDaysWeather
}

final class FetchWeatherListTranslator: FetchWeatherListTranslatorType {
  
  func execute(_ dto: FiveDaysWeatherDTO) -> FiveDaysWeather {
    return .init(
      city: dto.city.name,
      weather: dto.list.map {
        .init(
          icon: $0.weather.first?.icon ?? "default",
          status: $0.weather.description,
          teempMax: $0.main.tempMax,
          teempMin: $0.main.tempMin,
          date: $0.dtTxt.toDate(dateFormat: "yyyy-MM-dd HH:mm:ss")
        )
      }
    )
  }
}
