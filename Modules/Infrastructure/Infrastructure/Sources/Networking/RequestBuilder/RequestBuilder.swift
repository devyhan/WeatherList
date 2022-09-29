//
//  RequestBuilder.swift
//  Infrastructure
//
//  Created by YHAN on 2022/09/25.
//

import Utils
import RxSwift

public protocol RequestBuilder {
  func add(method: HTTPMethod) -> Self
  func add(headers: Dictionary<String, String>) -> Self
  func add(body: Dictionary<String, Any>) -> Self
  func add<R: Encodable>(body: R) -> Self
  func execute() -> Observable<Data>
}

final class RequestBuilderImpl: RequestBuilder {
  var url: URLRequest
  
  init(url: URLRequest) {
    self.url = url
  }
  
  func add(method: HTTPMethod) -> Self {
    url.httpMethod = method.rawValue
    return self
  }
  
  func add(headers: Dictionary<String, String>) -> Self {
    for header in headers {
      url.addValue(header.value, forHTTPHeaderField: header.key)
    }
    return self
  }
  
  func add(body: Dictionary<String, Any>) -> Self {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
      url.httpBody = jsonData
    } catch {
      print("Error \(error)")
    }
    return self
  }
  
  func add<R: Encodable>(body: R) -> Self {
    let jsonEncoder = JSONEncoder()
    do {
      let jsonData = try jsonEncoder.encode(body)
      url.httpBody = jsonData
    } catch {
      print("Error \(error)")
    }
    return self
  }
  
  func execute() -> Observable<Data> {
    return Observable.create { emitter in
      self.fetch { result in
        switch result {
        case let .success(data):
          emitter.onNext(data)
          emitter.onCompleted()
        case let .failure(error):
          emitter.onError(error)
        }
      }
      return Disposables.create()
    }
  }
  
  private func fetch(onComplete: @escaping (Result<Data, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, res, err in
      if let err = err {
        let err = err as NSError
        switch err.code {
        case NSURLErrorNotConnectedToInternet:
          DispatchQueue.main.async {
            let scenes = UIApplication.shared.windows
            let window = scenes.first?.rootViewController
            let alert = UIAlertController(title: "인터넷 연결을 확인해 주세요.", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "확인", style: .default) { action in
              if let settingUrl = URL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingUrl)
              }
              scenes.last?.removeFromSuperview()
            }
            alert.addAction(action)
            window?.present(alert, animated: true, completion: nil)
          }
        default:
          print("알 수 없는 문제")
        }
        onComplete(.failure(err))
      }
      
      guard let data = data else {
        if let statusCode = (res as? HTTPURLResponse)?.statusCode {
          switch statusCode {
          case 500...599:
            print("Server Error handling here.")
          default:
            print("알 수 없는 문제")
          }
        }
        
        onComplete(.failure(NSError(domain: "no data",
                                    code: (res as? HTTPURLResponse)?.statusCode ?? 1,
                                    userInfo: nil)))
        
        return
      }
      onComplete(.success(data))
    }.resume()
  }
}
