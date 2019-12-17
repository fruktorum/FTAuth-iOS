//
//  FTAuthPasswordTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTAuthPasswordTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.authPasswordTF = self
    }
    
    override func checkValidTextField() {
        self.descriptionLbl.isHidden = true
        if self.text == nil || self.text == "" {
            self.descriptionLbl.text = "The password cannot be blank"
            self.descriptionLbl.isHidden = false
        } else if !(self.text?.isValidPassword ?? false) {
            self.descriptionLbl.text = "The password must contain at least 8 characters"
            self.descriptionLbl.isHidden = false
        }
    }
}
