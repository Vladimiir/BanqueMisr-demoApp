//
//  DetailsView.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import SwiftUI

struct DetailsView: View {
    
    var vm: DetailsViewModel
    
    init(vm: DetailsViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        List {
            ForEach(vm.exchangesList, id: \.self) { exchange in
                VStack {
                    Text("\(exchange.fromCurrency) -> \(exchange.toCurrency)")
                    
                    Text("\(exchange.fromCurrencyAmount) -> \(exchange.toCurrencyAmount)")
                    
                    Text("\(exchange.date)")
                }
            }
        }
        .navigationTitle(Text("History"))
    }
}

