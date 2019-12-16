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
    
    public static var emailTextField: FTEmailTextField?
    public static var passwordTextField: FTPasswordTextField?
    
    public static let textFieldDelegate = FTTextFieldDelegate()
    static let presenter = Presenter()
    
    public static var errorOutputType: ErrorOutputType? = .log
    
    public static func login() {
        emailTextField?.checkValidTextField()
        passwordTextField?.checkValidTextField()
        if let email = emailTextField?.text, email.isValidEmail, let password = passwordTextField?.text, password.isValidPassword {
            presenter.auth(email, password, completionError: { errors in
                showError(errors: errors, outputType: errorOutputType)
            })
        }
    }
    
    public static func registration() {
        if let email = emailTextField?.text, email.isValidEmail, let password = passwordTextField?.text, password.isValidPassword {
            presenter.registration(email, password, completionError: { errors in
                showError(errors: errors, outputType: errorOutputType)
            })
        }
    }
    
    public static func logout() {
        presenter.logout(completionError: { errors in
            showError(errors: errors, outputType: errorOutputType)
        })
    }
    
    //MARK: DESIGN
}
