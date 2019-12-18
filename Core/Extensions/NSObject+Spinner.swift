//
//  NSObject+Spinner.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 18.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

extension NSObject {
    
    func displaySpinner() -> UIView {
        let spinnerView = UIView()
        if var topController = UIApplication.shared.windows.first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            guard let uiView = topController.view else { return spinnerView }
            let spinnerView = UIView.init(frame: uiView.bounds)
            spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView()
            if #available(iOS 13.0, *) {
                ai.style = .medium
            } else {
                ai.style = .white
            }
            ai.startAnimating()
            ai.center = spinnerView.center
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                uiView.addSubview(spinnerView)
            }
        }
        return spinnerView
    }
    
    func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.1)
        let ai = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            ai.style = .medium
        } else {
            ai.style = .white
        }
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    func removeSpinner(spinner: UIView) {
        print("removeSpinner \(spinner)")
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
