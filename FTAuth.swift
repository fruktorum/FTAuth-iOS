//
//  FTAuth.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

public class FTAuth {
    
    let presenter = Presenter()
    
    public static func login(_ email: String, _ password: String) {
        Presenter().auth(email, password)
    }
    
    public static func registration(_ email: String, _ password: String) {
        Presenter().registration(email, password)
    }
    
    
}
