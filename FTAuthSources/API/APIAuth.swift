//
//  API.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

class APIAuth {
    
    enum Email {
        case auth(_ email: String, _ password: String)
        case register(_ email: String?, _ password: String?, _ name: String?, _ firstName: String?, _ lastName: String?, _ phone: String?)
    }
    
    enum Apple {
        case auth(_ identityToken: String)
    }
    
    enum Session {
        case logout
    }
}

