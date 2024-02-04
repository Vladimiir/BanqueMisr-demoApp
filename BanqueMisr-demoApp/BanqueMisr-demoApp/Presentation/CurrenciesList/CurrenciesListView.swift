//
//  CurrenciesListView.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import SwiftUI

struct CurrenciesListView: View {
    
    @ObservedObject var vm: CurrenciesListViewModel
    
    init(vm: CurrenciesListViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Picker("FROM", selection: $vm.selectedFromCurrency) {
                    if let currenciesList = vm.currenciesList {
                        ForEach(Array(currenciesList.symbols.keys.enumerated()), id: \.element) { index, element in
                            Text("\(element)")
                                .tag(index)
                        }
                    }
                }
                .onChange(of: vm.selectedFromCurrency) { _, _ in
                    vm.updateRates()
                }
                
                Button(action: {
                    vm.swapCurrencies()
                }, label: {
                    Text("↔")
                        .font(.title)
                })
                
                Picker("TO", selection: $vm.selectedToCurrency) {
                    if let currenciesList = vm.currenciesList {
                        ForEach(Array(currenciesList.symbols.keys.enumerated()), id: \.element) { index, element in
                            Text("\(element)")
                                .tag(index)
                        }
                    }
                }
                .onChange(of: vm.selectedToCurrency) { _, _ in
                    vm.updateRates()
                }
            }
            .navigationTitle(Text("Currency!"))
        }
//        .task {
//            vm.viewWillAppear()
//        }
    }
}

#Preview {
    CurrenciesListView(vm: CurrenciesListViewModel())
}
