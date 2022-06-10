//
//  FTAuthRegistrationBtn.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTAuthRegistrationBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
    }
    
    @objc func touchUpInside(sender: UIButton) {
        superview?.endEditing(true)
        FTAuth.registration()
    }
}
