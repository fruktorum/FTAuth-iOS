//
//  FTAuth.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore


public class FTAuth: NSObject {
    
    public static var errorOutputType: ErrorOutputType? = .log
    public static var showSpinner = true
    
//    public static var loginViewForSpinner: UIView?
//    public static var registrationViewForSpinner: UIView?
//    public static var logoutViewForSpinner: UIView?
    
    public static var startLogin: (() -> Void)?
    public static var startRegistration: (() -> Void)?
    public static var startLogout: (() -> Void)?
    
    public static var successLogin: (() -> Void)?
    public static var successRegistration: (() -> Void)?
    public static var successLogout: (() -> Void)?
    
    public static var failureLogin: (() -> Void)?
    public static var failureRegistration: (() -> Void)?
    public static var failureLogout: (() -> Void)?
    
    public static var generalVerticalLocationOfDescription: CGFloat? {
        didSet {
            viewModel.updateConstrains(generalVerticalLocationOfDescription)
        }
    }

    static var authEmailTF: FTAuthEmailTextField?
    static var authPasswordTF: FTAuthPasswordTextField?
    
    static var registrationFirstNameTF: FTRegistrationFirstNameTextField?
    static var registrationLastNameTF: FTRegistrationLastNameTextField?
    static var registrationEmailTF: FTRegistrationEmailTextField?
    static var registrationPasswordTF: FTRegistrationPasswordTextField?
    static var registrationConfirmPasswordTF: FTRegistrationConfirmPasswordTextField?
    static var registrationPhoneTF: FTRegistrationPhoneTextField?
    
    static var registrationCheckerAcceptanceOfTerms: FTCheckerAcceptanceOfTerms?
    
    
    
    static let viewModel = FTAuthViewModel()
    static let presenter = Presenter()
    static let spinnerController = NSObject()
    
    
    
    static func login() {
        viewModel.checkDescriptionValidAuthTF()
        if let email = authEmailTF?.text,
            email.isValidEmail,
            let password = authPasswordTF?.text,
            password.isValidPassword {
                startLogin?()
                presenter.auth(email, password, completionError: { errors in
                    showError(errors: errors, outputType: errorOutputType, .login)
                    failureLogin?()
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
            let firstName = registrationFirstNameTF?.text,
            !firstName.isEmpty,
            let lastName = registrationLastNameTF?.text,
            !lastName.isEmpty {
                startRegistration?()
                presenter.registration(email, password, firstName, lastName, registrationPhoneTF?.text, completionError: { errors in
                    showError(errors: errors, outputType: errorOutputType, .registration)
                    failureRegistration?()
                })
        }
    }

    static func logout() {
        guard let _ = getSessionToken() else { return }
        startLogout?()
        presenter.logout(completionError: { errors in
            showError(errors: errors, outputType: errorOutputType)
            failureLogout?()
        })
    }
    
    static func facebookLogin() {
//        viewModel.checkDescriptionValidAuthTF()
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                showError(errors: errors, outputType: errorOutputType, .login)
                failureLogin?()
            case .cancelled:
                print("‼️ Facebook login cancel by user! ‼️")
            case .success(grantedPermissions: _, declinedPermissions: _, token: let accessToken):
                self.presenter.loginFbRequest(accessToken.authenticationToken)
                self.presenter.authFacebook(accessToken.authenticationToken, { errors in
                    showError(errors: errors, outputType: errorOutputType, .login)
                    failureLogin?()
                })
            }
        }
//        if let email = authEmailTF?.text,
//            email.isValidEmail,
//            let password = authPasswordTF?.text,
//            password.isValidPassword {
//                startLogin?()
//                presenter.auth(email, password, completionError: { errors in
//                    showError(errors: errors, outputType: errorOutputType, .login)
//                    failureLogin?()
//                })
//        }
    }
    
    //MARK: PUBLIC FUNCTION
    
    public static func getSessionToken() -> String? {
        return APIHeader.recieve(key: .session_token)
    }
    
    public static func getProviderToken() -> String? {
        return APIHeader.recieve(key: .provider_token)
    }
}
