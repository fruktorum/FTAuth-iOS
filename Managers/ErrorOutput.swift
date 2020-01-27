//
//  ErrorOutput.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 12.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation
import UIKit

public enum ErrorOutputType {
    case log
    case alert
}

enum RequestType {
    case login
    case registration
    case logout
}

enum KeyError: String {
    case email = "email"
    case password = "password"
    case firstName = "first_name"
    case lastName = "last_name"
    case phone = "phone"
}

extension NSObject {

    static func showError(errors: [ErrorModel]?, outputType: ErrorOutputType?, _ requestType: RequestType? = nil) {
        guard let errors = errors else { return }
        errors.forEach { error in
            if let key = error.key,
                let keyError = KeyError.init(rawValue: key) {
                DispatchQueue.main.async {
                    showInLabel(key: keyError, message: error.message, requestType)
                }
            } else {
                switch outputType {
                case .log, nil:
                    showInLog(error: error)
                case .alert:
                    showInAlert(error: error)}
            }
        }
    }
    
    private static func showInLog(error: ErrorModel?) {
        guard let error = error else { return }
        print("❌ FTAuth Error: \n \(error.key == nil ? "" : "key: \(String(describing: error.key))\n") \(error.message == nil ? "" : "message: \(String(describing: error.message))\n") ❌")
    }
    
    private static func showInAlert(error: ErrorModel?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in }))
            if var topController = UIApplication.shared.windows.first?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private static func showInLabel(key: KeyError, message: String?, _ requestType: RequestType?) {
        switch key {
        case .email:
            let emailTF = requestType == .login ? FTAuth.authEmailTF : FTAuth.registrationEmailTF
            emailTF?.descriptionLbl.text = message
            emailTF?.descriptionLbl.isHidden = false
        case .password:
            let passwordTF = requestType == .login ? FTAuth.authPasswordTF : FTAuth.registrationPasswordTF
            passwordTF?.descriptionLbl.text = message
            passwordTF?.descriptionLbl.isHidden = false
        case .firstName:
            FTAuth.registrationFirstNameTF?.descriptionLbl.text = message
            FTAuth.registrationFirstNameTF?.descriptionLbl.isHidden = false
        case .lastName:
            FTAuth.registrationLastNameTF?.descriptionLbl.text = message
            FTAuth.registrationLastNameTF?.descriptionLbl.isHidden = false
        case .phone:
            FTAuth.registrationPhoneTF?.descriptionLbl.text = message
            FTAuth.registrationPhoneTF?.descriptionLbl.isHidden = false
        }
    }
}
