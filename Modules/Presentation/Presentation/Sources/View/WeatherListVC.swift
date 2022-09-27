//
//  WeatherListVC.swift
//  Presentation
//
//  Created by YHAN on 2022/09/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

public final class WeatherListVC: UIViewController {
  private var viewModel = WeatherListVM()
 
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    setViews()
    setConstraint()
    setBindings()
  }
  
  private func setViews() {
    view.backgroundColor = .white
    
  }
  
  private func setConstraint() {
    
  }
  
  private func setBindings() {
    
  }
}
