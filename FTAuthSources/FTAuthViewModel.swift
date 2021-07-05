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
            case .confirmPassword:
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
                isValid = isValid ? FTAuth.registrationNameTF?.isValid ?? false : isValid
            case .firstName:
                isValid = isValid ? FTAuth.registrationFirstNameTF?.isValid ?? false : isValid
            case .lastName:
                isValid = isValid ? FTAuth.registrationLastNameTF?.isValid ?? false : isValid
            case .email:
                isValid = isValid ? FTAuth.registrationEmailTF?.isValid ?? false : isValid
            case .password:
                isValid = isValid ? FTAuth.registrationPasswordTF?.isValid ?? false : isValid
            case .confirmPassword:
                isValid = isValid ? FTAuth.registrationConfirmPasswordTF?.isValid ?? false : isValid
            case .phone:
                isValid = isValid ? FTAuth.registrationPhoneTF?.isValid ?? false : isValid
            case .accept:
                isValid = isValid ? FTAuth.registrationCheckerAcceptanceOfTerms?.isValid ?? false : isValid
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
    
    func settingDescriptionLbl(_ textColor: UIColor? = nil,
                                _ font: UIFont? = nil,
                                _ textAlignment: NSTextAlignment? = nil,
                                _ backgroundColor: UIColor? = nil,
                                _ attributedText: NSAttributedString? = nil,
                                _ lineBreakMode: NSLineBreakMode? = nil,
                                _ adjustsFontSizeToFitWidth: Bool? = nil,
                                _ minimumScaleFactor: CGFloat? = nil,
                                _ numberOfLines: Int? = nil,
                                _ highlightedTextColor: UIColor? = nil,
                                _ isHighlighted: Bool? = nil,
                                _ shadowColor: UIColor? = nil,
                                _ shadowOffset: CGSize? = nil) {
        FTAuth.authEmailTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.authPasswordTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.registrationEmailTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.registrationPasswordTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.registrationConfirmPasswordTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.registrationPhoneTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.registrationNameTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.registrationFirstNameTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
        FTAuth.registrationLastNameTF?.settingDescriptionLbl(textColor, font, textAlignment, backgroundColor, attributedText, lineBreakMode, adjustsFontSizeToFitWidth, minimumScaleFactor, numberOfLines, highlightedTextColor, isHighlighted, shadowColor, shadowOffset)
    }
}
