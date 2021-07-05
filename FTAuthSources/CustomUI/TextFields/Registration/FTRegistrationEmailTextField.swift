//
//  FTRegistrationEmailTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationEmailTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.email
        FTAuth.registrationEmailTF = self
    }
    
    override func checkValid() -> Bool {
        text?.isValidEmail ?? false
    }
    
    override func checkDescriptionValidTextField() {
        if FTAuth.requiredElements.contains(type) {
            descriptionLbl.text = "Incorrect email"
            descriptionLbl.isHidden = checkValid()
        } else {
            guard (text != nil && text != "") else { return }
            if !checkValid() {
                descriptionLbl.text = "Incorrect email"
                descriptionLbl.isHidden = checkValid()
            }
        }
    }
}
