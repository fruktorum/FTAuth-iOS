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
        FTAuth.requiredElements.forEach { element in
            switch element {
            case .none: break
            case .name:
                FTAuth.registrationNameTF?.checkDescriptionValidTextField()
            case .firstName:
                FTAuth.registrationFirstNameTF?.checkDescriptionValidTextField()
            case .lastName:
                FTAuth.registrationLastNameTF?.checkDescriptionValidTextField()
            case .email:
                FTAuth.registrationEmailTF?.checkDescriptionValidTextField()
            case .password:
                FTAuth.registrationPasswordTF?.checkDescriptionValidTextField()
                FTAuth.registrationConfirmPasswordTF?.checkDescriptionValidTextField()
            case .phone:
                FTAuth.registrationPhoneTF?.checkDescriptionValidTextField()
            case .accept:
                FTAuth.registrationCheckerAcceptanceOfTerms?.checkValid()
            }
        }
    }
    
    func checkValidAllElements() -> Bool {
        var isValid = true
        FTAuth.requiredElements.forEach { element in
            switch element {
            case .none: break
            case .name:
                isValid = FTAuth.registrationNameTF?.isValid ?? false
            case .firstName:
                isValid = FTAuth.registrationFirstNameTF?.isValid ?? false
            case .lastName:
                isValid = FTAuth.registrationLastNameTF?.isValid ?? false
            case .email:
                isValid = FTAuth.registrationEmailTF?.isValid ?? false
            case .password:
                isValid = FTAuth.registrationPasswordTF?.isValid ?? false
                isValid = FTAuth.registrationConfirmPasswordTF?.isValid ?? false
            case .phone:
                isValid = FTAuth.registrationPhoneTF?.isValid ?? false
            case .accept:
                isValid = FTAuth.registrationCheckerAcceptanceOfTerms?.isValid ?? false
            }
        }
        return isValid
    }
    
    
    
    
    
    
    func updateConstrains(_ generalVerticalLocationOfDescription: CGFloat?) {
        FTAuth.authEmailTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.authPasswordTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationEmailTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationPasswordTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationConfirmPasswordTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationPhoneTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationNameTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationFirstNameTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
        FTAuth.registrationLastNameTF?.setVerticalLocationOfDescription(generalVerticalLocationOfDescription)
    }
}

