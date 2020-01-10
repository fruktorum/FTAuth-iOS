//
//  APIHeared.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

struct APIHeader {
    
    enum HeaderKey: String, CaseIterable {
        case session_token = "session_token"
        case provider_token = "provider_token"
    }
    
    static func save(value: Any, key: HeaderKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func recieve(key: HeaderKey) -> String? {
        guard let value = UserDefaults.standard.value(forKey: key.rawValue) as? String else { return nil }
        return value
    }
    
    static func remove() {
        for key in HeaderKey.allCases {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
