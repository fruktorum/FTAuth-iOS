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
        FTAuth.registrationEmailTF = self
    }
    
    override func checkDescriptionValidTextField() {
        self.descriptionLbl.text = "Incorrect email"
        self.descriptionLbl.isHidden = self.text?.isValidEmail ?? false
    }
}
