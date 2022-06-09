//
//  FTRegistrationConfirmPasswordTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationConfirmPasswordTextField: FTTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        type = TypeElement.confirmPassword
        FTAuth.registrationConfirmPasswordTF = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.confirmPassword
        FTAuth.registrationConfirmPasswordTF = self
    }
    
    override func checkValid() -> Bool {
        return text == FTAuth.registrationPasswordTF?.text
    }
    
    override func checkDescriptionValidTextField() {
        descriptionLbl.isHidden = true
        if !checkValid() {
            descriptionLbl.text = "Passwords do not match"
            descriptionLbl.isHidden = false
        }
    }
}
