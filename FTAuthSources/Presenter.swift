//
//  Presenter.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

class Presenter: NSObject {
    
    // MARK: - Methods
    
    func auth(_ email: String, _ password: String) {
        postAuth(email, password)
    }
    
    func authApple(_ identityToken: String) {
        postApple(identityToken)
    }
    
    func registration(_ email: String?, _ password: String?, _ name: String?, _ firstName: String?, _ lastName: String?, _ phone: String?) {
        postRegistration(email, password, name, firstName, lastName, phone)
    }
    
    func logout(sessionToken: String) {
        postLogout(sessionToken: sessionToken)
    }
    
    // MARK: - Private methods
    
    private func postAuth(_ email: String, _ password: String) {
        let spinner = displaySpinner()
        APIAuth.Email.auth(email, password).responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
            if let error = error {
                self.failLogin(FTErrorModel(key: nil, message: error.localizedDescription))
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(AuthResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        guard let session_token = responseModel.session_token, let provider_token = responseModel.provider_token else { return }
                        APIHeader.save(value: session_token, key: .session_token)
                        APIHeader.save(value: provider_token, key: .provider_token)
                        FTAuth.viewModel.cleanAuthTF()
                        DispatchQueue.main.async {
                            FTAuth.completionHandlerLogin?(.success(responseModel))
                        }
                    case false:
                        guard let error = responseModel.errors?.first else { return }
                        self.failLogin(error)
                    default:
                        break
                    }
                } else {
                    self.failLogin(FTErrorModel(key: nil, message: error?.localizedDescription))
                }
            }
        }
    }
    
    private func postApple(_ identityToken: String) {
        let spinner = displaySpinner()
        APIAuth.Apple.auth(identityToken).responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
            if let error = error {
                self.failLogin(FTErrorModel(key: nil, message: error.localizedDescription))
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(AuthResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        guard let session_token = responseModel.session_token, let provider_token = responseModel.provider_token else { return }
                        APIHeader.save(value: session_token, key: .session_token)
                        APIHeader.save(value: provider_token, key: .provider_token)
                        FTAuth.viewModel.cleanAuthTF()
                        DispatchQueue.main.async {
                            FTAuth.completionHandlerLogin?(.success(responseModel))
                        }
                    case false:
                        guard let error = responseModel.errors?.first else { return }
                        self.failLogin(error)
                    default:
                        break
                    }
                } else {
                    self.failLogin(FTErrorModel(key: nil, message: error?.localizedDescription))
                }
            }
        }
    }
    
    private func postRegistration(_ email: String?, _ password: String?, _ name: String?, _ firstName: String?, _ lastName: String?, _ phone: String?) {
        let spinner = displaySpinner()
        APIAuth.Email.register(email, password, name, firstName, lastName, phone).responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
            if let error = error {
                self.failRegistration(FTErrorModel(key: nil, message: error.localizedDescription))
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(AuthResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        guard let session_token = responseModel.session_token, let provider_token = responseModel.provider_token else { return }
                        APIHeader.save(value: session_token, key: .session_token)
                        APIHeader.save(value: provider_token, key: .provider_token)
                        FTAuth.viewModel.cleanRegistrationTF()
                        DispatchQueue.main.async {
                            FTAuth.completionHandlerRegistration?(.success(responseModel))
                        }
                    case false:
                        guard let error = responseModel.errors?.first else { return }
                        self.failRegistration(error)
                    default:
                        break
                    }
                } else {
                    self.failRegistration(FTErrorModel(key: nil, message: error?.localizedDescription))
                }
            }
        }
    }
    
    private func postLogout(sessionToken: String) {
        let spinner = displaySpinner()
        APIHeader.remove()
        FTAuth.startLogout?()
        APIAuth.Session.logout(sessionToken).responseSimpleData { (data, error) in
            self.removeSpinner(spinner: spinner)
            if let error = error {
                self.failLogout(FTErrorModel(key: nil, message: error.localizedDescription))
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                    switch responseModel.success {
                    case true:
                        DispatchQueue.main.async {
                            FTAuth.completionHandlerLogout?(.success(responseModel))
                        }
                    case false:
                        guard let error = responseModel.errors?.first else { return }
                        self.failLogout(error)
                    default:
                        break
                    }
                } else {
                    self.failLogout(FTErrorModel(key: nil, message: error?.localizedDescription))
                }
            }
        }
    }
    
    private func failLogin(_ error: FTErrorModel?) {
        guard let error = error else { return }
        NSObject.showError(errors: [error], outputType: FTAuth.errorOutputType, .login)
        FTAuth.completionHandlerLogin?(.failure(error))
    }
    
    private func failRegistration(_ error: FTErrorModel?) {
        guard let error = error else { return }
        NSObject.showError(errors: [error], outputType: FTAuth.errorOutputType, .registration)
        FTAuth.completionHandlerRegistration?(.failure(error))
    }
    
    private func failLogout(_ error: FTErrorModel?) {
        guard let error = error else { return }
        NSObject.showError(errors: [error], outputType: FTAuth.errorOutputType)
        FTAuth.completionHandlerLogout?(.failure(error))
    }
}
