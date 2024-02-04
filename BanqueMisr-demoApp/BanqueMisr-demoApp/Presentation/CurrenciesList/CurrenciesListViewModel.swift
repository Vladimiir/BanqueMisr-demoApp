//
//  CurrenciesListViewModel.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation

class CurrenciesListViewModel: ObservableObject {
    
    // Mostly for assigning values I prefer to use DI (Swinject, Typhoon, swift-dependencies)
    // For SwiftUI in the last projet I used "https://github.com/pointfreeco/swift-dependencies"
    // But for the demo project I will create dependencies manually
    private var currenciesService: ICurrenciesService = CurrenciesService()
    
    func viewWillAppear() {
        currenciesService.fetchAllSupportedSymbols { currenciesList in
            
        }
    }
}
