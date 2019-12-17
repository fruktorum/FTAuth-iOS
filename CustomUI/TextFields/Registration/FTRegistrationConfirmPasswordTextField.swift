//
//  FTRegistrationConfirmPasswordTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationConfirmPasswordTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.registrationConfirmPasswordTF = self
    }
    
    override func checkDescriptionValidTextField() {
        self.descriptionLbl.isHidden = true
        if self.text != FTAuth.registrationPasswordTF?.text {
            self.descriptionLbl.text = "Passwords do not match"
            self.descriptionLbl.isHidden = false
        }
    }
}
