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
    
    @Published var currenciesList: CurrenciesListModel?
    @Published var exchangeRates: CurrencyExchangeRates?
    
    @Published var selectedFromCurrency = "EUR"
    @Published var selectedToCurrency = "USD"
    @Published var textFromCurrency = "1"
    @Published var textToCurrency = ""
    
    /// To prevent the 'fetchRates()' double call
    var isSwapCurrenciesPressed = false
    
    /// The list of made currency exchanges
    var exchangesList: [CurrencyExchange] = []
    
    @Published var isCurrenciesPreloaded = false
    
    func viewWillAppear() {
        currenciesService.fetchAllSupportedSymbols { [weak self] currenciesList in
            DispatchQueue.main.async {
                self?.currenciesList = currenciesList!
                self?.isCurrenciesPreloaded = true
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
        addExchangeToList()
    }
    
    func addExchangeToList() {
        exchangesList.append(CurrencyExchange(fromCurrency: selectedFromCurrency,
                                              toCurrency: selectedToCurrency,
                                              fromCurrencyAmount: textFromCurrency,
                                              toCurrencyAmount: textToCurrency,
                                              date: exchangeRates?.date ?? ""))
    }
    
    func swapCurrencies() {
        isSwapCurrenciesPressed = true
        let from = selectedFromCurrency
        selectedFromCurrency = selectedToCurrency
        selectedToCurrency = from
    }
    
    func detailsButtonDidPress() {
        
    }
}
