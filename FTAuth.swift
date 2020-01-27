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
    
    public static var webView: UIView?
    public static var activityIndicator: UIActivityIndicatorView?
    public static var backgroundColorOfActivityIndicator: UIColor?
    public static var errorOutputType: ErrorOutputType? = .log
    public static var showSpinner = true
    public static var requiredElements = [TypeElement]()
    static var authServerURL = ""
    
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
    
    static var registrationNameTF: FTRegistrationNameTextField?
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
        if viewModel.checkValidAllElements() {
                startRegistration?()
                presenter.registration(registrationEmailTF?.text, registrationPasswordTF?.text, registrationNameTF?.text, registrationFirstNameTF?.text, registrationLastNameTF?.text, registrationPhoneTF?.text, completionError: { errors in
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
    
    //MARK: PUBLIC FUNCTION
    public static func setAuthSerevrURL(_ url: String) {
        authServerURL = url
    }
    
//    public static func facebookLogin(_ facebookToken: String) {
//        startLogin?()
//        self.presenter.authFacebook(facebookToken, { errors in
//            showError(errors: errors, outputType: errorOutputType, .login)
//            failureLogin?()
//        })
//    }
    
    public static func settingDescriptionLabel(textColor: UIColor? = nil,
                                        font: UIFont? = nil,
                                        textAlignment: NSTextAlignment? = nil,
                                        backgroundColor: UIColor? = nil,
                                        attributedText: NSAttributedString? = nil,
                                        lineBreakMode: NSLineBreakMode? = nil,
                                        adjustsFontSizeToFitWidth: Bool? = nil,
                                        minimumScaleFactor: CGFloat? = nil,
                                        numberOfLines: Int? = nil,
                                        highlightedTextColor: UIColor? = nil,
                                        isHighlighted: Bool? = nil,
                                        shadowColor: UIColor? = nil,
                                        shadowOffset: CGSize? = nil) {
        viewModel.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
    }
    
    public static func getSessionToken() -> String? {
        return APIHeader.recieve(key: .session_token)
    }
    
    public static func getProviderToken() -> String? {
        return APIHeader.recieve(key: .provider_token)
    }
    
    public static func setProviderToken(_ providerToken: String) {
        APIHeader.save(value: providerToken, key: .provider_token)
    }
    
    public static func setSessionToken(_ sessionToken: String) {
        APIHeader.save(value: sessionToken, key: .session_token)
    }
}

