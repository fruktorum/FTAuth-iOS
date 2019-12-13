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
//    static public var verticalLocationOfDescription: CGFloat? {
//        didSet {
//            emailTextField?.verticalLocationOfDescription = verticalLocationOfDescription
//        }
//    }
    
    static public func login(_ email: String, _ password: String) {
        print("emailTextField?.text\(emailTextField?.text)")
        print("passwordTextField?.text\(passwordTextField?.text)")
        if let email = emailTextField?.text, email.isValidEmail, let password = passwordTextField?.text, !password.isEmpty {
            presenter.auth(email, password, completionError: { errorMessage in
                showError(message: errorMessage, outputType: errorOutputType)
            })
        }
    }
    
    static public func registration(_ email: String, _ password: String) {
        presenter.registration(email, password, completionError: { errorMessage in
            showError(message: errorMessage, outputType: errorOutputType)
        })
    }
    
    static public func logout() {
        presenter.logout(completionError: { errorMessage in
            showError(message: errorMessage, outputType: errorOutputType)
        })
    }
}
