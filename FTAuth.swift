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
    
    static public let textFieldDelegate = FTTextFieldDelegate()
    static let presenter = Presenter()
    
    static public var errorOutputType: ErrorOutputType? = .log
    
    static public func login() {
        if let email = emailTextField?.text, email.isValidEmail, let password = passwordTextField?.text, !password.isEmpty {
            presenter.auth(email, password, completionError: { errors in
                showError(errors: errors, outputType: errorOutputType)
            })
        }
    }
    
    static public func registration() {
        if let email = emailTextField?.text, email.isValidEmail, let password = passwordTextField?.text, !password.isEmpty {
            presenter.registration(email, password, completionError: { errors in
                showError(errors: errors, outputType: errorOutputType)
            })
        }
    }
    
    static public func logout() {
        presenter.logout(completionError: { errors in
            showError(errors: errors, outputType: errorOutputType)
        })
    }
    
    //MARK: DESIGN
}
