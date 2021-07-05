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
        type = TypeElement.firstName
        FTAuth.registrationFirstNameTF = self
    }
    
    override func checkDescriptionValidTextField() {
        if FTAuth.requiredElements.contains(type) {
            descriptionLbl.text = "First name cannot be blank"
            descriptionLbl.isHidden = !(text?.isEmpty ?? true)
        }
    }
}

public class FTRegistrationLastNameTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.lastName
        FTAuth.registrationLastNameTF = self
    }
    
    override func checkDescriptionValidTextField() {
        if FTAuth.requiredElements.contains(type) {
            descriptionLbl.text = "Last name cannot be blank"
            descriptionLbl.isHidden = !(text?.isEmpty ?? true)
        }
    }
}

public class FTRegistrationNameTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.name
        FTAuth.registrationNameTF = self
    }
    
    override func checkDescriptionValidTextField() {
        if FTAuth.requiredElements.contains(type) {
            descriptionLbl.text = "Name cannot be blank"
            descriptionLbl.isHidden = !(text?.isEmpty ?? true)
        }
    }
}
