//
//  AppleAuthorizationService.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 16.04.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import Foundation
import AuthenticationServices

class AppleAuthorizationService: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    var didReceiveIdentityToken: ((String) -> Void)?
    
    func configureAuthorization() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: - ASAuthorizationControllerDelegate
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
    
    // MARK: - ASAuthorizationControllerDelegate
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("ℹ️ FTAuth ℹ️ ❌ Error Apple authorization: \(error.localizedDescription)")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let identityTokenData = appleIDCredential.identityToken {
                guard let identityTokenStr = String(data: identityTokenData, encoding: String.Encoding.utf8) else { return }
                print("ℹ️ FTAuth ℹ️❗️Apple identityToken = \(identityTokenStr)")
                didReceiveIdentityToken?(identityTokenStr)
            }
        }
    }
}
