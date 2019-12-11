////
////  Presenter.swift
////  FTAuth
////
////  Created by Герасимов Тимофей Владимирович on 09.12.2019.
////  Copyright © 2019 Fruktorum. All rights reserved.
////
//
//import Foundation
//
//class Presenter: NSObject {
//    
//    var tokens = BehaviorRelay<AuthTokenModel?>(value: nil)
//    let disposeBag = DisposeBag()
//    
//    func auth(_ email: String, password: String) {
//        
//    }
//    
//    func requestRegistration(_ email: String, _ password: String) {
//        registration(email, password)
//    }
//    
//    func logout() {
//        
//    }
//    
//    private func registration(_ email: String, _ password: String) {
//        postRegistration(email, password)
//            .takeUntil(rx.deallocated)
//            .subscribeOn(ConcurrentMainScheduler.instance)
//            .subscribe(onNext: { [weak self] in
//                guard let `self` = self else { return }
//                self.tokens.accept($0)
//                }, onError: { error in
//                    self.showHandlerError(error)
//            }).disposed(by: disposeBag)
//    }
//    
//    private func postRegistration(_ email: String, _ password: String) -> Observable<AuthTokenModel?> {
//        return Observable<AuthTokenModel?>.create({ (observer) -> Disposable in
//            return API.Auth.authorization(email, password).responseSimpleData()
//                .subscribe(onNext: { data in
//                    do {
//                        let responseModel = try JSONDecoder().decode(AuthTokenResponseModel.self, from: data)
//                        guard let success = responseModel.success else {
//                            observer.onError(GeneralError.noSuccessKey)
//                            return }
//                        if success {
//                            guard  let deviceToken = responseModel.device_token, let smsToken = responseModel.sms_token else { return }
//                            let tokens = AuthTokenModel(deviceToken: deviceToken, smsToken: smsToken)
//                            observer.onNext(tokens)
//                        } else if let errorType = responseModel.error {
//                            observer.onError(GeneralError.errorType(errorType))
//                        }
//                        observer.onCompleted()
//                    } catch let error {
//                        observer.onError(GeneralError.simpleError(error))
//                        observer.onCompleted()
//                    }
//                }, onError: { error in
//                    observer.onError(GeneralError.simpleError(error))
//                    observer.onCompleted()
//                })
//        })
//    }
//}
//
//
//import Foundation
//
//class AuthTokenResponseModel: Decodable {
//    var success: Bool?
//    var error: ErrorType?
//    var device_token: String?
//    var sms_token: String?
//}
//
//class AuthTokenModel {
//    var deviceToken: String
//    var smsToken: String
//    
//    init(deviceToken: String, smsToken: String) {
//        self.deviceToken = deviceToken
//        self.smsToken = smsToken
//    }
//}
//
//
//
//extension NSObject {
//    
//    func showHandlerError(_ error: Error) {
//        ErrorChecker.shared.error.accept(error)
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
