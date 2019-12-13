//
//  API.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

// MARK: - API.Auth

class APIAuth {
    
    enum Email {
        case auth(_ email: String, _ password: String)
        case register(_ email: String, _ password: String)
    }

    enum Facebook {
        case auth(_ fbToken: String)
    }
    
    enum Session {
        case logout
    }
}
