//
//  FTAuth.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation
import UIKit

public class FTAuth: NSObject {
    
    public static var errorOutputType: ErrorOutputType? = .log
    
    public static var successAuth: (() -> Void)?
    public static var successRegistration: (() -> Void)?
    public static var successLogout: (() -> Void)?
    
    public static var failureAuth: (() -> Void)?
    public static var failureRegistration: (() -> Void)?
    public static var failureLogout: (() -> Void)?

    static var authEmailTF: FTAuthEmailTextField?
    static var authPasswordTF: FTAuthPasswordTextField?
    
    static var registrationFullNameTF: FTRegistrationFullNameTextField?
    static var registrationEmailTF: FTRegistrationEmailTextField?
    static var registrationPasswordTF: FTRegistrationPasswordTextField?
    static var registrationConfirmPasswordTF: FTRegistrationConfirmPasswordTextField?
    static var registrationPhoneTF: FTRegistrationPhoneTextField?
    
    static var registrationCheckerAcceptanceOfTerms: FTCheckerAcceptanceOfTerms?
    
    static let viewModel = FTAuthViewModel()
    static let presenter = Presenter()
    
    
    
    static func login() {
        viewModel.checkDescriptionValidAuthTF()
        if let email = authEmailTF?.text,
            email.isValidEmail,
            let password = authPasswordTF?.text,
            password.isValidPassword {

                presenter.auth(email, password, completionError: { errors in
                    showError(errors: errors, outputType: errorOutputType)
                    failureAuth?()
                })
        }
    }

    static func registration() {
        viewModel.checkDescriptionValidRegistrationTF()
        if let email = registrationEmailTF?.text,
            email.isValidEmail,
            let password = registrationPasswordTF?.text,
            password.isValidPassword,
            let confirmParrword = registrationConfirmPasswordTF?.text,
            confirmParrword == password,
            (registrationCheckerAcceptanceOfTerms == nil ||
            registrationCheckerAcceptanceOfTerms?.checked ?? false),
            let name = registrationFullNameTF?.text,
            !name.isEmpty {

                presenter.registration(email, password, name, registrationPhoneTF?.text, completionError: { errors in
                    showError(errors: errors, outputType: errorOutputType)
                    failureRegistration?()
                })
        }
    }

    static func logout() {
        presenter.logout(completionError: { errors in
            showError(errors: errors, outputType: errorOutputType)
            failureLogout?()
        })
    }
    
    public static func getSessionToken() -> String? {
        return APIHeader.recieve(key: .session_token)
    }
    
    public static func getProviderToken() -> String? {
        return APIHeader.recieve(key: .provider_token)
    }
}
