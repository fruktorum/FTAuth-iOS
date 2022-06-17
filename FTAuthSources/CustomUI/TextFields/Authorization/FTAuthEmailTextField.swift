//
//  FTAuthEmailTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTAuthEmailTextField: FTTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        FTAuth.authEmailTF = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FTAuth.authEmailTF = self
    }
    
    public override func checkValid() -> Bool {
        text?.isValidEmail ?? false
    }
    
    override func checkDescriptionValidTextField() {
        descriptionLbl.text = "Incorrect email"
        descriptionLbl.isHidden = checkValid()
    }
}
