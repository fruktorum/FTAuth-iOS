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
    
    func authApple(_ identityToken: String,_ completionError: @escaping (_ errors: [ErrorModel]?)  -> Void) {
        postApple(identityToken, completionError)
    }
    
    func registration(_ email: String?, _ password: String?, _ name: String?, _ firstName: String?, _ lastName: String?, _ phone: String?, completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
        postRegistration(email, password, name, firstName, lastName, phone, completionError)
    }
    
    func logout(completionError: @escaping (_ error: [ErrorModel]?) -> Void) {
        postLogout(completionError)
    }
    
    private func postAuth(_ email: String, _ password: String,_ completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
        let spinner = displaySpinner()
        APIAuth.Email.auth(email, password).responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
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
                        DispatchQueue.main.async {
                            FTAuth.successLogin?()
                        }
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
    
    private func postApple(_ identityToken: String,_ completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
        let spinner = displaySpinner()
        APIAuth.Apple.auth(identityToken).responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
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
                        DispatchQueue.main.async {
                            FTAuth.successLogin?()
                        }
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
    
    private func postRegistration(_ email: String?, _ password: String?, _ name: String?, _ firstName: String?, _ lastName: String?, _ phone: String?,_ completionError: @escaping (_ errors: [ErrorModel]?) -> Void) {
        let spinner = displaySpinner()
        APIAuth.Email.register(email, password, name, firstName, lastName, phone).responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
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
                        DispatchQueue.main.async {
                            FTAuth.successRegistration?()
                        }
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
        let spinner = displaySpinner()
        APIAuth.Session.logout.responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
            if let error = error {
                completionError([ErrorModel(key: nil, message: error.localizedDescription)])
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        APIHeader.remove()
                        DispatchQueue.main.async {
                            FTAuth.successLogout?()
                        }
                    case false:
                        APIHeader.remove()
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
