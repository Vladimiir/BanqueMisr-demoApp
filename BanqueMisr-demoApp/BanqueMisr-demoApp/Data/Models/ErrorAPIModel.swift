//
//  ErrorAPIModel.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation

struct ErrorAPIModel: Codable, Error {
    let success: Bool
    let error: ErrorModel
    
    struct ErrorModel: Codable {
        let code: Int
        let info: String
    }
}

