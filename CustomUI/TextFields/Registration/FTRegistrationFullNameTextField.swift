//
//  FTRegistrationFullNameTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationFirstNameTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.registrationFirstNameTF = self
    }
    
    override func checkDescriptionValidTextField() {
        self.descriptionLbl.text = "First name cannot be blank"
        self.descriptionLbl.isHidden = !(self.text?.isEmpty ?? true)
    }
}

import UIKit

public class FTRegistrationLastNameTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.registrationLastNameTF = self
    }
    
    override func checkDescriptionValidTextField() {
        self.descriptionLbl.text = "Last name cannot be blank"
        self.descriptionLbl.isHidden = !(self.text?.isEmpty ?? true)
    }
}
