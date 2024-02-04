//
//  CurrenciesService.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation

protocol ICurrenciesService {
    
    func fetchAllSupportedSymbols(handler: @escaping (CurrenciesListModel?) -> ())
}

class CurrenciesService: HTTPClient, ICurrenciesService {
    
    func fetchAllSupportedSymbols(handler: @escaping (CurrenciesListModel?) -> ()) {
        guard let url = URL(string: ServicesEndpoints.currenciesPath) else {
            handler(nil)
            return
        }
        
        get(with: url,
            type: CurrenciesListModel.self) { result in
            handler(result)
        }
    }
}
