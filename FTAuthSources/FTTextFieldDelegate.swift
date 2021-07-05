//
//  FTTextFieldDelegate.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 12.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

class FTTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? FTTextField else { return }
        textField.checkDescriptionValidTextField()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? FTTextField else { return }
        textField.cleanTextFieldDescription()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let phoneField = textField as? FTRegistrationPhoneTextField else { return true }
        return phoneField.textField(phoneField, shouldChangeCharactersIn: range, replacementString: string)
    }
}
