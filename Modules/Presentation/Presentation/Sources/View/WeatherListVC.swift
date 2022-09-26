//
//  WeatherListVC.swift
//  Presentation
//
//  Created by YHAN on 2022/09/25.
//

import UIKit
import SnapKit

public final class WeatherListVC: UIViewController {
  
  private var text: UILabel = {
    let label = UILabel()
    label.text = "Title"
    return label
  }()
 
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    setViews()
    setConstraint()
  }
  
  private func setViews() {
    view.backgroundColor = .white
    
    view.addSubview(text)
    

    
  }
  
  private func setConstraint() {
    text.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }
}

