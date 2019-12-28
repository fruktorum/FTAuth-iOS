//
//  FTRegistrationPhoneTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationPhoneTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.phone
        FTAuth.registrationPhoneTF = self
    }
    
    override func checkValid() -> Bool {
        text?.isValidPhone ?? false
    }
    
    override func checkDescriptionValidTextField() {
        descriptionLbl.isHidden = true
        if text == nil || text == "" {
            descriptionLbl.text = "The phone cannot be blank"
            descriptionLbl.isHidden = false
        } else if !checkValid() {
            descriptionLbl.text = "Incorrect phone"
            descriptionLbl.isHidden = false
        }
    }
}
