//
//  FTRegistrationPhoneTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationPhoneTextField: FTTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.phone
        FTAuth.registrationPhoneTF = self
    }
    
    override func checkValid() -> Bool {
        text?.isValidPhone ?? false
    }
    
    override func checkDescriptionValidTextField() {
        descriptionLbl.isHidden = true
        if FTAuth.requiredElements.contains(type) {
            if text == nil || text == "" {
                descriptionLbl.text = "The phone cannot be blank"
                descriptionLbl.isHidden = false
            } else if !checkValid() {
                descriptionLbl.text = "Incorrect phone"
                descriptionLbl.isHidden = false
            }
        } else {
            guard (text != nil && text != "") else { return }
            if !checkValid() {
                descriptionLbl.text = "Incorrect phone"
                descriptionLbl.isHidden = false
            }
        }
    }
    
    private func formattedNumber(number: String) -> String {
        print("formattedNumber \(number)")
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X (XXX) XXX-XXXX"

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                print(2)
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                print(3)
                result.append(ch)
            }
        }
        print(4)
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("FTRegistrationPhoneTextField shouldChangeCharactersIn \(string)")
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedNumber(number: newString)
        
        return false
    }
}

