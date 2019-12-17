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
        FTAuth.registrationPhoneTF = self
    }
    
    override func checkValidTextField() {
//        self.descriptionLbl.isHidden = true
//        if self.text == nil || self.text == "" {
//            self.descriptionLbl.text = "The phone cannot be blank"
//            self.descriptionLbl.isHidden = false
//        } else if !(self.text?.isValidPhone ?? false) {
//            self.descriptionLbl.text = "Incorrect phone"
//            self.descriptionLbl.isHidden = false
//        }
    }
}
