//
//  FetchWeatherList.swift
//  Domain
//
//  Created by YHAN on 2022/09/25.
//

import Container
import RxSwift

public protocol FetchWeatherList: Injectable {
  func execute(city: String) -> Observable<FiveDaysWeather>
}
