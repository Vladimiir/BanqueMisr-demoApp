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
    
    // TODO: preload data and then pass it here without force unwrap
    @Published var currenciesList: CurrenciesListModel!
    @Published var exchangeRates: CurrencyExchangeRates?
    
    @Published var selectedFromCurrency = "EUR"
    @Published var selectedToCurrency = "USD"
    @Published var textFromCurrency = "1"
    @Published var textToCurrency = ""
    
    // TODO: move it somewhere?
    @Published var isLoaded = false
    
    func viewWillAppear() {
        currenciesService.fetchAllSupportedSymbols { [weak self] currenciesList in
            DispatchQueue.main.async {
                self?.currenciesList = currenciesList!
                self?.isLoaded = true
                self?.fetchRates()
            }
        }
    }
    
    func fetchRates() {
        currenciesService.fetchLatestEndpoints(fromCurrency: selectedFromCurrency,
                                               toCurrency: selectedToCurrency) { [weak self] exchangeRates in
            DispatchQueue.main.async {
                self?.exchangeRates = exchangeRates
                self?.updateRates()
            }
        }
    }
    
    func updateRates() {
        guard let rate = exchangeRates?.rates.first?.value,
              let decimalFromCurrency = Decimal(string: self.textFromCurrency)
        else {
            return
        }
        
        self.textToCurrency = "\(decimalFromCurrency * rate)"
    }
    
    func swapCurrencies() {
        // FIXME: double call of 'fetchRates()'
        let from = selectedFromCurrency
        selectedFromCurrency = selectedToCurrency
        selectedToCurrency = from
    }
}
