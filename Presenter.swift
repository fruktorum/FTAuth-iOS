//
//  Presenter.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

class Presenter: NSObject {
    
    func auth(_ email: String, _ password: String) {
        postAuth(email, password)
    }
    
    private func postAuth(_ email: String, _ password: String) {
        APIAuth.Email.auth(email, password).responseSimpleData { (data, error) in
            if let error = error {
//                showError(message: error.localizedDescription)
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(AuthResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        guard let session_token = responseModel.session_token else { return }
                    case false:
                        let errorMsg = responseModel.errors
                        errorMsg?.forEach { error in
                            print("Error: \(error.key == nil ? "" : "\n key: \(error.key!)") \(error.message == nil ? "" : "\n message: \(error.message!)")")
                        }
//                        showError(message: errorMsg ?? "Server error")
                    default:
                        break
                    }
                } else {
//                    showError(message: "Decoding json error")
                }
            }
        }
    }
}



extension NSObject {
    
    func showHandlerError(_ error: Error) {
//        ErrorChecker.shared.error.accept(error)
        
//        if let error = self as? GeneralError {
//            self.showError(message: error.msg)
//        } else {
//            self.showError(message: error.localizedDescription)
//        }
    }
}

//class ErrorChecker: NSObject {
//
//    static let shared = ErrorChecker()
//    var error = BehaviorRelay<Error?>(value: nil)
//    var isShowed = false
//    let disposeBag = DisposeBag()
//
//    private override init() {
//        super.init()
//        setupBindings()
//    }
//
//    private func setupBindings() {
//        error
//            .throttle(.seconds(3), scheduler: MainScheduler.instance)
//            .bind(onNext: { [weak self] error in
//                guard let `self` = self, let error = error else { return }
//                if !self.isShowed {
//                    self.showError(error)
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//
//    private func showError(_ error: Error) {
//        if let error = error as? GeneralError {
//            self.showError(message: checkNetworkConnected(error.msg))
//        } else {
//            self.showError(message: checkNetworkConnected(error.localizedDescription))
//        }
//    }
//
//    private func checkNetworkConnected(_ error: String) -> String {
//        return error == "The Internet connection appears to be offline." ? "Подключение к интернету, похоже, отключено." : error
//    }
//}

//NSObject + Alert
//import UIKit
//
//extension NSObject {
//
//    func showSuccess(message: String) {
//        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in }))
//        if var topController = UIApplication.shared.keyWindow?.rootViewController {
//            while let presentedViewController = topController.presentedViewController {
//                topController = presentedViewController
//            }
//            topController.present(alert, animated: true, completion: nil)
//        }
//    }
//
//    func showError(message: String) {
//        ErrorChecker.shared.isShowed = true
//        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
//            ErrorChecker.shared.isShowed = false
//        }))
//        if var topController = UIApplication.shared.keyWindow?.rootViewController {
//            while let presentedViewController = topController.presentedViewController {
//                topController = presentedViewController
//            }
//            topController.present(alert, animated: true, completion: nil)
//        }
//    }
//
//    func showMessage(title: String, message: String, _ handler: (() -> Void)? = nil) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in handler?() }))
//        if var topController = UIApplication.shared.keyWindow?.rootViewController {
//            while let presentedViewController = topController.presentedViewController {
//                topController = presentedViewController
//            }
//            topController.present(alert, animated: true, completion: nil)
//        }
//    }
//}
