//
//  FTAuthEmailTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTAuthEmailTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.authEmailTF = self
    }
    
    override func checkValid() -> Bool {
        text?.isValidEmail ?? false
    }
    
    override func checkDescriptionValidTextField() {
        descriptionLbl.text = "Incorrect email"
        descriptionLbl.isHidden = checkValid()
    }
}

