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

    static var authEmailTF: FTAuthEmailTextField?
    static var authPasswordTF: FTAuthPasswordTextField?
    
    static var registrationFullNameTF: FTRegistrationFullNameTextField?
    static var registrationEmailTF: FTRegistrationEmailTextField?
    static var registrationPasswordTF: FTRegistrationPasswordTextField?
    static var registrationConfirmPasswordTF: FTRegistrationConfirmPasswordTextField?
    static var registrationPhoneTF: FTRegistrationPhoneTextField?
    
    static var registrationCheckerAcceptanceOfTerms: FTCheckerAcceptanceOfTerms?
    
    static let textFieldDelegate = FTTextFieldDelegate()
    static let presenter = Presenter()
    
    static func cleanAuthTF() {
        DispatchQueue.main.async {
            authEmailTF?.text = nil
            authPasswordTF?.text = nil
        }
    }
    
    static func cleanRegistrationTF() {
        DispatchQueue.main.async {
            registrationFullNameTF?.text = nil
            registrationEmailTF?.text = nil
            registrationPasswordTF?.text = nil
            registrationConfirmPasswordTF?.text = nil
            registrationPhoneTF?.text = nil
        }
    }

    static func login() {
        authEmailTF?.checkValidTextField()
        authPasswordTF?.checkValidTextField()
        if let email = authEmailTF?.text,
            email.isValidEmail,
            let password = authPasswordTF?.text,
            password.isValidPassword {
            
                presenter.auth(email, password, completionError: { errors in
                    showError(errors: errors, outputType: errorOutputType)
                })
        }
    }
    
    static func registration() {
        registrationEmailTF?.checkValidTextField()
        registrationPasswordTF?.checkValidTextField()
        registrationConfirmPasswordTF?.checkValidTextField()
        registrationFullNameTF?.checkValidTextField()
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
                    })
        }
    }
    
    static func logout() {
        presenter.logout(completionError: { errors in
            showError(errors: errors, outputType: errorOutputType)
        })
    }
    
    
    public static func getSessionToken() -> String? {
        return APIHeader.recieve(key: .session_token)
    }
    
    public static func getProviderToken() -> String? {
        return APIHeader.recieve(key: .provider_token)
    }
}
