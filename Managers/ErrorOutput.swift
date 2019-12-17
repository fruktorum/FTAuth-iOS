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

enum KeyError: String {
    case email = "email"
    case password = "password"
    case fullName = "full_name"
    case phone = "phone"
}

extension NSObject {

    static func showError(errors: [ErrorModel]?, outputType: ErrorOutputType?) {
        guard let errors = errors else { return }
        errors.forEach { error in
            if let key = error.key,
                let keyError = KeyError.init(rawValue: key) {
                DispatchQueue.main.async {
                    showInLabel(key: keyError, message: error.message)
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
        print("❌ FTAuth Error: \n \(error.key == nil ? "" : "key: \(error.key?.description)\n") \(error.message == nil ? "" : "message: \(error.message?.description)\n") ❌")
    }
    
    private static func showInAlert(error: ErrorModel?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in }))
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private static func showInLabel(key: KeyError, message: String?) {
        switch key {
        case .email:
            FTAuth.authEmailTF?.descriptionLbl.text = message
            FTAuth.authEmailTF?.descriptionLbl.isHidden = false
        case .password:
            FTAuth.authPasswordTF?.descriptionLbl.text = message
            FTAuth.authPasswordTF?.descriptionLbl.isHidden = false
        case .fullName:
            FTAuth.registrationFullNameTF?.descriptionLbl.text = message
            FTAuth.registrationFullNameTF?.descriptionLbl.isHidden = false
        case .phone:
            FTAuth.registrationPhoneTF?.descriptionLbl.text = message
            FTAuth.registrationPhoneTF?.descriptionLbl.isHidden = false
        }
    }
}
