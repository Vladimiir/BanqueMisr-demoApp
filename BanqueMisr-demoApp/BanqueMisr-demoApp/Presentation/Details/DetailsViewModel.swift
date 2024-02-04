//
//  DetailsViewModel.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 05.02.2024.
//

import Foundation

class DetailsViewModel: ObservableObject {
    
    var exchangesList: [CurrencyExchange]
    
    init(exchangesList: [CurrencyExchange]) {
        self.exchangesList = exchangesList
    }
}
