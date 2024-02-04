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
            VStack {
                HStack {
                    // TODO: separate all these views
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
                
                HStack {
                    TextField(text: $vm.textFromCurrency) {
                        Text("")
                    }
                    .minimumScaleFactor(0.1)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .border(Color.gray, width: 1)
                    .onChange(of: vm.textFromCurrency) { _, _ in
                        vm.updateRates()
                    }
                    
                    Spacer()
                        .frame(width: 20)
                    
                    TextField(text: $vm.textToCurrency) {
                        Text("")
                    }
                    .minimumScaleFactor(0.1)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .border(Color.gray, width: 1)
                    .onChange(of: vm.textToCurrency) { _, _ in
                        vm.updateRates()
                    }
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 15)
                
                Button(action: {
                    
                }, label: {
                    Text("Details")
                        .font(.title3)
                })
            }
            .navigationTitle(Text("Currency!"))
        }
    }
}

#Preview {
    CurrenciesListView(vm: CurrenciesListViewModel())
}
