//
//  NSObject+Spinner.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 18.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

extension NSObject {
    
    func displaySpinner() -> UIView? {
        guard FTAuth.showSpinner else { return nil }
        if var topController = UIApplication.shared.windows.first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            guard let view = topController.view else { return nil }
            let spinnerView = UIView(frame: view.frame)
            spinnerView.backgroundColor = FTAuth.backgroundColorOfActivityIndicator ?? UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = FTAuth.activityIndicator ?? UIActivityIndicatorView(style: .medium)
            ai.center = spinnerView.center
            DispatchQueue.main.async {
                ai.startAnimating()
                spinnerView.addSubview(ai)
                view.addSubview(spinnerView)
            }
            return spinnerView
        }
        return nil
    }
    
    func removeSpinner(spinner: UIView?) {
        DispatchQueue.main.async {
            spinner?.removeFromSuperview()
        }
    }
}
