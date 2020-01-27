//
//  FTAuthFacebookBtn.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 27.01.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import UIKit
import WebKit

public class FTAuthFacebookBtn: UIButton {
    
    lazy var webView = WKWebView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
    }
    
    @objc func touchUpInside(sender: UIButton) {
        superview?.endEditing(true)
        createWebView()
    }
    
    private func createWebView() {
        webView.isUserInteractionEnabled = true
        webView.load(URLRequest(url: URL(string: "\(AUTH_SERVER_URL)/facebook?mobile=true")!))
        print("\(AUTH_SERVER_URL)/facebook?mobile=true")
        webView.navigationDelegate = self
        if let view = FTAuth.webView {
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
}


extension FTAuthFacebookBtn: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let params = webView.url?.params() {
            print("params: \(params)")
            if let error_reason = params["error_reason"], error_reason == "user_denied" {
                webView.stopLoading()
                webView.removeFromSuperview()
            }
        }
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let params = webView.url?.params() {
            if let session_token = params["session_token"], let provider_token = params["provider_token"] {
                APIHeader.save(value: session_token, key: .session_token)
                APIHeader.save(value: provider_token, key: .provider_token)
                webView.stopLoading()
                webView.removeFromSuperview()
                FTAuth.successLogin?()
            }
        }
    }
}
