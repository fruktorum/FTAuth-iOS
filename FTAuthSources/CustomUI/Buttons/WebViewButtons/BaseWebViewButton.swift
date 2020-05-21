//
//  BaseWebViewButton.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 28.01.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import UIKit
import WebKit

public class BaseWebViewButton: UIButton {
    
    lazy var webView = WKWebView()
    var spinner: UIView?
    var url = ""
    var customUserAgent: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
    }
    
    @objc func touchUpInside(sender: UIButton) {
        superview?.endEditing(true)
        createWebView()
    }
    
    private func addWebViewOnSuperview() {
        if let view = FTAuth.webView {
            view.isHidden = false
            webView.frame = view.frame
            view.addSubview(webView)
        } else {
            if var topController = UIApplication.shared.windows.first?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                webView.frame = topController.view.frame
                topController.view.addSubview(webView)
            }
        }
    }
    
    private func createWebView() {
        webView.customUserAgent = customUserAgent ?? webView.customUserAgent
        webView.load(URLRequest(url: URL(string: url)!))
        webView.navigationDelegate = self
        webView.alpha = 0
        addWebViewOnSuperview()
        UIView.animate(withDuration: 0.3, animations: {
            self.webView.alpha = 1
        })
        webView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:))))
    }
    
    private func closeWebView() {
        removeSpinner(spinner: spinner)
        UIView.animate(withDuration: 0.3, animations: {
            self.webView.alpha = 0
        }, completion: { _ in
            self.webView.stopLoading()
            self.webView.removeFromSuperview()
            FTAuth.webView?.isHidden = true
        })
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        let originalLocation = webView.center
        if gesture.direction == .right {
            UIView.animate(withDuration: 0.3, animations: {
                self.webView.center.x = originalLocation.x + self.webView.frame.width
            }, completion: { (value: Bool) in
                self.closeWebView()
            })
        }
    }
}


extension BaseWebViewButton: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner = displaySpinner()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        closeWebView()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.innerHTML") { (html, error) in
          guard let html = html as? String else {
            print(error)
            return
          }
        }
        
        removeSpinner(spinner: spinner)
        if let params = webView.url?.params() {
            print("params: \(params)")
            if let error_reason = params["error_reason"], error_reason == "user_denied" {
                closeWebView()
            }
        }
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let params = webView.url?.params() {
            print("PARAMS = \(params)")
            if let session_token = params["session_token"], let provider_token = params["provider_token"] {
                APIHeader.save(value: session_token, key: .session_token)
                APIHeader.save(value: provider_token, key: .provider_token)
                closeWebView()
                let result = AuthResponseModel()
                result.set(session_token, provider_token)
                FTAuth.completionHandlerLogin?(.success(result))
                //----- !!! for refactoring:
            } else if let errors = params["errors"] as? [String: String], let key = errors["key"], let message = errors["message"] {
                if key == "email", message == "has already been taken" {
                    closeWebView()
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "This email is already registered under an existing account. Please try another login method.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in }))
                        if var topController = UIApplication.shared.windows.first?.rootViewController {
                            while let presentedViewController = topController.presentedViewController {
                                topController = presentedViewController
                            }
                            topController.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
            //------
        }
    }
}
