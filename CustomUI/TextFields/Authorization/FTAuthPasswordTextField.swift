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
    
    override func checkValid() -> Bool {
        text?.isValidPassword ?? false
    }
    
    override func checkDescriptionValidTextField() {
        self.descriptionLbl.isHidden = true
        if text == nil || text == "" {
            descriptionLbl.text = "The password cannot be blank"
            descriptionLbl.isHidden = false
        } else if !checkValid() {
            descriptionLbl.text = "The password must contain at least 8 characters"
            descriptionLbl.isHidden = false
        }
    }
}
