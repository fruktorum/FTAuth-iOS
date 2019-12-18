//
//  Presenter.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

class Presenter: NSObject {
    
    func auth(_ email: String, _ password: String, completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
        postAuth(email, password, completionError)
    }
    
    func registration(_ email: String, _ password: String, _ name: String, _ phone: String?, completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
        postRegistration(email, password, name, phone, completionError)
    }
    
    func logout(completionError: @escaping (_ error: [ErrorModel]?) -> Void) {
        postLogout(completionError)
    }
    
    private func postAuth(_ email: String, _ password: String,_ completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
//        let spinner = displaySpinner()
        APIAuth.Email.auth(email, password).responseSimpleData { (data, error) in
//            self.removeSpinner(spinner: spinner)
            if let error = error {
                completionError([ErrorModel(key: nil, message: error.localizedDescription)])
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(AuthResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        guard let session_token = responseModel.session_token, let provider_token = responseModel.provider_token else { return }
                        APIHeader.save(value: session_token, key: .session_token)
                        APIHeader.save(value: provider_token, key: .provider_token)
                        FTAuth.viewModel.cleanAuthTF()
                        FTAuth.successLogin?()
                    case false:
//                        if let errorType = responseModel.errors {
//                            print(GeneralError.errorType(errorType).msg)
//                        }
                        let errors = responseModel.errors
                        completionError(errors)
                    default:
                        break
                    }
                } else {
                    completionError([ErrorModel(key: nil, message: error?.localizedDescription)])
                }
            }
        }
    }
        
    private func postRegistration(_ email: String, _ password: String, _ name: String, _ phone: String?,_ completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
        APIAuth.Email.register(email, password, name, phone).responseSimpleData { (data, error) in
            if let error = error {
                completionError([ErrorModel(key: nil, message: error.localizedDescription)])
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(AuthResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        guard let session_token = responseModel.session_token, let provider_token = responseModel.provider_token else { return }
                        APIHeader.save(value: session_token, key: .session_token)
                        APIHeader.save(value: provider_token, key: .provider_token)
                        FTAuth.viewModel.cleanRegistrationTF()
                        FTAuth.successRegistration?()
                    case false:
//                        if let errorType = responseModel.errors {
//                            print(GeneralError.errorType(errorType).msg)
//                        }
                        let errors = responseModel.errors
                        completionError(errors)
                    default:
                        break
                    }
                } else {
                    completionError([ErrorModel(key: nil, message: error?.localizedDescription)])
                }
            }
        }
    }
        
    private func postLogout(_ completionError: @escaping (_ error: [ErrorModel]?) -> Void) {
        APIAuth.Session.logout.responseSimpleData { (data, error) in
            if let error = error {
                completionError([ErrorModel(key: nil, message: error.localizedDescription)])
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        APIHeader.remove()
                        FTAuth.successLogout?()
                    case false:
                        if let errorType = responseModel.errors {
                            completionError([ErrorModel(key: nil, message: GeneralError.errorType(errorType).msg)])
                        }
                    default:
                        break
                    }
                } else {
                    completionError([ErrorModel(key: nil, message: error?.localizedDescription)])
                }
            }
        }
    }
}



//extension NSObject {
//    
//    func showHandlerError(_ error: Error) {
//        ErrorChecker.shared.error = error
//        
////        if let error = self as? GeneralError {
////            self.showError(message: error.msg)
////        } else {
////            self.showError(message: error.localizedDescription)
////        }
//    }
//}
//
//class ErrorChecker: NSObject {
//
//    static let shared = ErrorChecker()
//    var error: Error? {
//        didSet {
//            guard let error = error else { return }
//            if !self.isShowed {
//                self.showError(error)
//            }
//        }
//    }
//    var isShowed = false
//
//    private override init() {
//        super.init()
////        setupBindings()
//    }
//
////    private func setupBindings() {
////        error
////            .throttle(.seconds(3), scheduler: MainScheduler.instance)
////            .bind(onNext: { [weak self] error in
////                guard let `self` = self, let error = error else { return }
////                if !self.isShowed {
////                    self.showError(error)
////                }
////            })
////            .disposed(by: disposeBag)
////    }
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
//
////NSObject + Alert
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
