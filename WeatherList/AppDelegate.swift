//
//  AppDelegate.swift
//  WeatherList
//
//  Created by 조요한 on 2022/09/23.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let viewController = ViewController()
    self.window?.rootViewController = UINavigationController(rootViewController: viewController)
    self.window?.makeKeyAndVisible()
    return true
  }
}

