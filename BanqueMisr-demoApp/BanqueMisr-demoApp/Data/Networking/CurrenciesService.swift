//
//  CurrenciesService.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation

protocol ICurrenciesService {
    
    func fetchAllSupportedSymbols(handler: @escaping (CurrenciesListModel?) -> ())
    
    func fetchLatestEndpoints(fromCurrency: String,
                              toCurrency: String,
                              handler: @escaping (CurrencyExchangeRates?) -> ())
}

class CurrenciesService: HTTPClient, ICurrenciesService {
    
    func fetchAllSupportedSymbols(handler: @escaping (CurrenciesListModel?) -> ()) {
        let url = URLConstructor.addParams(to: ServicesEndpoints.symbolsPath,
                                           params: [.access_key: ServicesEndpoints.accessKey])
        
        guard let url else {
            handler(nil)
            return
        }
        
        get(with: url,
            type: CurrenciesListModel.self) { result in
            handler(result)
        }
    }
    
    func fetchLatestEndpoints(fromCurrency: String,
                              toCurrency: String,
                              handler: @escaping (CurrencyExchangeRates?) -> ()) {
        let url = URLConstructor.addParams(to: ServicesEndpoints.latestPath,
                                           params: [.access_key: ServicesEndpoints.accessKey,
                                                    .base: fromCurrency,
                                                    .symbols: toCurrency])
        
        guard let url else {
            handler(nil)
            return
        }
        
        get(with: url,
            type: CurrencyExchangeRates.self) { result in
            handler(result)
        }
    }
}
