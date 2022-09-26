//
//  ViewController.swift
//  WeatherList
//
//  Created by 조요한 on 2022/09/23.
//

import Container
import Data
import UIKit

class ViewController: UIViewController {
  @Injected var sample: SampleDependency
  @Injected var fetchWeatherList: FetchWeatherListImpl
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    print(sample.execute())
    fetchWeatherList.execute(city: "Seoul")
  }
}
