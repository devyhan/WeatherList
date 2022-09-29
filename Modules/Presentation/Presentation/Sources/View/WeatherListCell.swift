//
//  WeatherListCell.swift
//  Presentation
//
//  Created by 조요한 on 2022/09/28.
//

import Domain
import UIKit
import Utils
import SnapKit

final class WeatherListCell: UITableViewCell {
  static let identifier: String = "WeatherListCell"
  
  private var iconView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = UIColor(assetName: .backgroundReverse)
    return imageView
  }()
  
  private lazy var currentDayLabel: UILabel = {
    let label = UILabel()
    label.layer.opacity = 0.5
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return label
  }()
  
  private lazy var weatherDetailLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    label.layer.opacity = 0.5
    return label
  }()
  
  private lazy var maxTemperatureLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    label.layer.opacity = 0.5
    return label
  }()
  
  private lazy var minTemperatureLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    label.layer.opacity = 0.5
    return label
  }()
  
  var rowItem: Weather? {
    didSet {
      if let rowItem = rowItem {
        iconView.image = UIImage(named: String(rowItem.icon.dropLast()))
        currentDayLabel.text = rowItem.date?.toLocalizedRelativeDate
        weatherDetailLabel.text = rowItem.status
        
        let unit = Locale.current.temperatureUnit == .fahrenheit ? "℉" : "℃"
        maxTemperatureLabel.text = "Max: \(Int(rowItem.teempMax))\(unit)"
        minTemperatureLabel.text = "Min: \(Int(rowItem.teempMin))\(unit)"
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setLayout()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    self.rowItem = nil
  }
  
  private func setLayout() {
    [currentDayLabel, iconView, weatherDetailLabel, maxTemperatureLabel, minTemperatureLabel].forEach {
      self.addSubview($0)
    }
  }
  
  private func setConstraints() {
    currentDayLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalToSuperview().offset(20)
    }
    
    iconView.snp.makeConstraints { make in
      make.width.height.equalTo(50)
      make.top.equalTo(currentDayLabel.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(20)
    }
    
    weatherDetailLabel.snp.makeConstraints { make in
      make.leading.equalTo(iconView.snp.trailing).offset(10)
      make.bottom.equalToSuperview().offset(-10)
    }
    
    minTemperatureLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-20)
      make.bottom.equalToSuperview().offset(-10)
    }
    
    maxTemperatureLabel.snp.makeConstraints { make in
      make.trailing.equalTo(minTemperatureLabel.snp.leading).offset(-10)
      make.bottom.equalToSuperview().offset(-10)
    }
  }
}
