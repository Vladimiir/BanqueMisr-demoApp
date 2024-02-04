//
//  CurrenciesListModel.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation

struct CurrenciesListModel: Codable, Hashable {
    let success: Bool
    let symbols: [String: String]
}
