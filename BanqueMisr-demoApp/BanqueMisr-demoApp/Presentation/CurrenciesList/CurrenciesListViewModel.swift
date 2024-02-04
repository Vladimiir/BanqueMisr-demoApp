//
//  CurrenciesListViewModel.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation
import SwiftUI

class CurrenciesListViewModel: ObservableObject {
    
    // Mostly for assigning values I prefer to use DI (Swinject, Typhoon, swift-dependencies)
    // For SwiftUI in the last projet I used "https://github.com/pointfreeco/swift-dependencies"
    // But for the demo project I will create dependencies manually
    private var currenciesService: ICurrenciesService = CurrenciesService()
    
    @Published var currenciesList: CurrenciesListModel!
    @Published var selectedFromCurrency = "USD"
    @Published var selectedToCurrency = "EUR"
    
    // TODO: move it somewhere?
    @Published var isLoaded = false
    
    func viewWillAppear() {
        currenciesService.fetchAllSupportedSymbols { [weak self] currenciesList in
            DispatchQueue.main.async {
                self?.currenciesList = currenciesList!
                self?.isLoaded = true
            }
        }
    }
    
    func updateRates() {
        
    }
    
    func swapCurrencies() {
        
    }
}
