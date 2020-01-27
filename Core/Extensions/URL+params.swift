//
//  URL+params.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 27.01.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import Foundation

extension URL {
    func params() -> [String: String] {
        var dict = [String: String]()
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    dict[item.name] = item.value
                }
            }
            return dict
        } else {
            return [:]
        }
    }
}
