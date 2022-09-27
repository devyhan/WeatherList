//
//  WeatherListVM.swift
//  Presentation
//
//  Created by 조요한 on 2022/09/27.
//

import Container
import RxCocoa
import RxSwift

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}

public final class WeatherListVM: ViewModelType {
  @Injected(\.repository.sampleDomain) private var sampleDomain
  
  struct Input {}
  
  struct Output {}
  
  public init() {
    print(sampleDomain.execute())
  }
  
  func transform(input: Input) -> Output {
    return Output()
  }
}
