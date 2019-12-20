//
//  FTAuthViewModel.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 18.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

class FTAuthViewModel: NSObject {
    
    let textFieldDelegate = FTTextFieldDelegate()
    
    func cleanAuthTF() {
        DispatchQueue.main.async {
            FTAuth.authEmailTF?.text = nil
            FTAuth.authPasswordTF?.text = nil
        }
    }
    
    func cleanRegistrationTF() {
        DispatchQueue.main.async {
            FTAuth.registrationFirstNameTF?.text = nil
            FTAuth.registrationLastNameTF?.text = nil
            FTAuth.registrationEmailTF?.text = nil
            FTAuth.registrationPasswordTF?.text = nil
            FTAuth.registrationConfirmPasswordTF?.text = nil
            FTAuth.registrationPhoneTF?.text = nil
        }
    }
    
    func checkDescriptionValidAuthTF() {
        FTAuth.authEmailTF?.checkDescriptionValidTextField()
        FTAuth.authPasswordTF?.checkDescriptionValidTextField()
    }
    
    func checkDescriptionValidRegistrationTF() {
        FTAuth.registrationEmailTF?.checkDescriptionValidTextField()
        FTAuth.registrationPasswordTF?.checkDescriptionValidTextField()
        FTAuth.registrationConfirmPasswordTF?.checkDescriptionValidTextField()
        FTAuth.registrationFirstNameTF?.checkDescriptionValidTextField()
        FTAuth.registrationLastNameTF?.checkDescriptionValidTextField()
    }
    
    func updateConstrains(_ generalVerticalLocationOfDescription: CGFloat?) {
        FTAuth.authEmailTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.authPasswordTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationEmailTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationPasswordTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationConfirmPasswordTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationFirstNameTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationLastNameTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
    }
}
