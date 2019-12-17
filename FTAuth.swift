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
    
    static var registrationEmailTF: FTRegistrationEmailTextField?
    static var registrationPasswordTF: FTRegistrationPasswordTextField?
    static var registrationConfirmPasswordTF: FTRegistrationConfirmPasswordTextField?
    
    static let textFieldDelegate = FTTextFieldDelegate()
    static let presenter = Presenter()

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
        if let email = registrationEmailTF?.text,
            email.isValidEmail,
            let password = registrationPasswordTF?.text,
            password.isValidPassword,
            let confirmParrword = registrationConfirmPasswordTF?.text,
            confirmParrword == password  {
            presenter.registration(email, password, completionError: { errors in
                showError(errors: errors, outputType: errorOutputType)
            })
        }
    }
    
    static func logout() {
        presenter.logout(completionError: { errors in
            showError(errors: errors, outputType: errorOutputType)
        })
    }
}
