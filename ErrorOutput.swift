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
    case aboveTextField
    case underTextField
}

extension NSObject {

    static func showError(message: String, outputType: ErrorOutputType?) {
        switch outputType {
        case .log:
            print("❌ FTAuth Error: \(message) ❌")
        case .alert:
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in }))
                if var topController = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    topController.present(alert, animated: true, completion: nil)
                }
            }
        case .aboveTextField:
            DispatchQueue.main.async {
                print("❌ FTAuth Error: \(message) ❌")
            }
            break
        case .underTextField:
            DispatchQueue.main.async {
                print("❌ FTAuth Error: \(message) ❌")
            }
            break
        case nil:
            print("❌ FTAuth Error: \(message) ❌")
//        default:
//            print("❌ FTAuth Error: \(message) ❌")
        }
    }
}
