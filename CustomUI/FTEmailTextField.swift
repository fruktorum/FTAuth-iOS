//
//  FTEmailTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTEmailTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.emailTextField = self
    }
    
    override func checkValidTextField() {
        self.descriptionLbl.text = "Incorrect email"
        self.descriptionLbl.isHidden = self.text?.isValidEmail ?? false
    }
}
