//
//  String + Validation.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 12.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation


extension String {
    
    var isValidEmail: Bool {
//        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
//        return emailPredicate.evaluate(with: self)
        guard self.contains("@"), self.contains(".") else { return false }
        return true
    }
    
//    var isValidPassword: Bool {
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*#?&]).{8,}")
//        return passwordTest.evaluate(with: self)
//    }
    
}
