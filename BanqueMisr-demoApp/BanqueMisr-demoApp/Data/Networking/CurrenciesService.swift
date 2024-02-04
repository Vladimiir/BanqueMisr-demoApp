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
        let url = URLConstructor.addParams(to: ServicesEndpoints.currenciesPath,
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
    
    func fetchLatestEndpoints(handler: @escaping (CurrenciesListModel?) -> ()) {
        let url = URLConstructor.addParams(to: ServicesEndpoints.currenciesPath,
                                           params: [.access_key: ServicesEndpoints.accessKey,
                                                    .base: "USD",
                                                    .symbols: "GBP"])
        
        guard let url else {
            handler(nil)
            return
        }
        
        get(with: url,
            type: CurrenciesListModel.self) { result in
            handler(result)
        }
    }
}
