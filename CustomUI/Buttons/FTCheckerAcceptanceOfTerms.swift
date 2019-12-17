//
//  FTCheckerAcceptanceOfTerms.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

//@IBDesignable
public class FTCheckerAcceptanceOfTerms: UIButton {
    
    public var checked: Bool = false
    public var imageOn: UIImage?
    public var imageOff: UIImage?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        FTAuth.registrationCheckerAcceptanceOfTerms = self
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
        updateImage()
    }
    
    @objc func touchUpInside(sender: UIButton) {
        checked = !checked
        updateImage()
    }
    
    func updateImage() {
        if let imageOn = imageOn, let imageOff = imageOff {
            self.setImage(checked ? imageOn : imageOff , for: .normal)
        } else {
            self.tintColor = self.tintColor.withAlphaComponent(checked ? 1 : 0.3)
        }
    }
    
    public func set(checked: Bool, imageOn: UIImage, imageOff: UIImage) {
        self.checked = checked
        self.imageOn = imageOn
        self.imageOff = imageOff
        updateImage()
    }
}
