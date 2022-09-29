//
//  WeatherListVC.swift
//  Presentation
//
//  Created by YHAN on 2022/09/25.
//

import Domain
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxAppState

public struct SectionWeatherData: Equatable {
  public var header: String
  public var items: [Weather]
  
  public init(header: String, items: [Weather]) {
    self.header = header
    self.items = items
  }
}

extension SectionWeatherData: SectionModelType {
  public init(original: SectionWeatherData, items: [Weather]) {
    self = original
    self.items = items
  }
}

public final class WeatherListVC: UIViewController {
  private var viewModel = WeatherListVM()
  private var disposeBag = DisposeBag()
  
  private var viewDidLoadSubject = PublishSubject<Void>()
  private lazy var input = WeatherListVM.Input(
    viewDidLoad: self.viewDidLoadSubject.asObservable(),
    refreshControlAction: self.refreshControl.rx.controlEvent(.valueChanged).asObservable()
  )
  private lazy var output = self.viewModel.transform(input: input)
  
  private let refreshControl = UIRefreshControl()
  
  private var sections: [SectionWeatherData] = []
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero)
    tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.identifier)
    tableView.refreshControl = refreshControl
    tableView.refreshControl?.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    return tableView
  }()
  
  private let dataSource = RxTableViewSectionedReloadDataSource<SectionWeatherData>(
    configureCell: { (_, tableView, indexPath, element) in
      let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.identifier, for: indexPath) as! WeatherListCell
      cell.selectionStyle = .none
      cell.rowItem = element
      
      return cell
    },
    titleForHeaderInSection: { dataSource, sectionIndex in
      return dataSource[sectionIndex].header
    }
  )
  
  private lazy var spinner: UIView = {
    let view = UIView(
      frame:
        CGRect(
          x: UIScreen.main.bounds.width / 2 - 20,
          y: UIScreen.main.bounds.height / 2 + 20,
          width: 40,
          height: 40
        )
    )
    let spinner = UIActivityIndicatorView()
    spinner.center = view.center
    view.addSubview(spinner)
    spinner.startAnimating()
    return view
  }()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    setViews()
    setConstraint()
    setBindings()
  }
  
  private func setViews() {
    navigationItem.title = "WeatherList"
    view.backgroundColor = .white
    view.addSubview(tableView)
    view.addSubview(spinner)
  }
  
  private func setConstraint() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setBindings() {
    rx.viewDidAppear
      .subscribe(onNext: { [weak self] _ in
        guard let self else { return }
        self.viewDidLoadSubject.onNext(())
      })
      .disposed(by: disposeBag)
    
    tableView.rx.setDelegate(self)
      .disposed(by: disposeBag)
    
    output.weatherList
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    output.refreshControlCompelted
      .drive { [weak self] _ in
        guard let self = self else { return }
        self.tableView.refreshControl?.endRefreshing()
      }
      .disposed(by: disposeBag)
    
    output.isLoadingSpinnerAvaliable
      .drive { [weak self] isAvaliable in
        guard let self = self else { return }
        self.spinner.isHidden = !isAvaliable
        self.tableView.backgroundView = isAvaliable ? self.spinner : UIView(frame: .zero)
      }
      .disposed(by: disposeBag)
  }
}

extension WeatherListVC: UIScrollViewDelegate, UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView else { return }
    header.textLabel?.textColor = UIColor(assetName: .backgroundReverse)
    header.textLabel?.layer.opacity = 0.7
    header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
  }
}
