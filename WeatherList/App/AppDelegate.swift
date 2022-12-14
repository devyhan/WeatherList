//
//  AppDelegate.swift
//  WeatherList
//
//  Created by ์กฐ์ํ on 2022/09/23.
//

import Container
import Presentation
import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let viewController = WeatherListVC()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: viewController)
    window?.makeKeyAndVisible()
    return true
  }
}
