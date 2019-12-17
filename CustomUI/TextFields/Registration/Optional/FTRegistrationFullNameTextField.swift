//
//  FTRegistrationFullNameTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationFullNameTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.registrationFullNameTF = self
    }
    
    override func checkDescriptionValidTextField() {
        self.descriptionLbl.text = "Name cannot be blank"
        self.descriptionLbl.isHidden = !(self.text?.isEmpty ?? true)
    }
}
