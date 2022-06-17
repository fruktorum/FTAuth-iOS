//
//  FTRegistrationPasswordTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationPasswordTextField: FTTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        type = TypeElement.password
        FTAuth.registrationPasswordTF = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.password
        FTAuth.registrationPasswordTF = self
    }
    
    public override func checkValid() -> Bool {
        text?.isValidPassword ?? false
    }
    
    override func checkDescriptionValidTextField() {
        descriptionLbl.isHidden = true
        if self.text == nil || self.text == "" {
            descriptionLbl.text = "The password cannot be blank"
            descriptionLbl.isHidden = false
        } else if !checkValid() {
            descriptionLbl.text = "The password must contain at least 8 characters"
            descriptionLbl.isHidden = false
        }
    }
}
