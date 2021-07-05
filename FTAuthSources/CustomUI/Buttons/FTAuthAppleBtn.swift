//
//  FTAuthAppleBtn.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 16.04.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import UIKit

public class FTAuthAppleBtn: UIButton {
    
    private var authorizationService = AppleAuthorizationService()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
    }
    
    @objc func touchUpInside(sender: UIButton) {
        superview?.endEditing(true)
        authorizationService.configureAuthorization()
        authorizationService.didReceiveIdentityToken = { [weak self] identityToken in
            guard let self = self else { return }
            FTAuth.loginWithApple(identityToken)
        }
    }
}
