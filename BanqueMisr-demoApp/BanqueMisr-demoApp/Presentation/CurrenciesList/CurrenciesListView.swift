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
                    Picker("FROM", selection: $vm.selectedFromCurrency) {
                        if let currenciesList = vm.currenciesList {
                            ForEach(Array(currenciesList.symbols.keys.sorted().enumerated()),
                                    id: \.element) { index, element in
                                Text("\(element)")
                                    .tag(index)
                            }
                        }
                    }
                    .onChange(of: vm.selectedFromCurrency) { _, _ in
                        vm.fetchRates()
                    }
                    
                    Button(action: {
                        vm.swapCurrencies()
                    }, label: {
                        Text("↔")
                            .font(.title)
                    })
                    
                    Picker("TO", selection: $vm.selectedToCurrency) {
                        if let currenciesList = vm.currenciesList {
                            ForEach(Array(currenciesList.symbols.keys.sorted().enumerated()),
                                    id: \.element) { index, element in
                                Text("\(element)")
                                    .tag(index)
                            }
                        }
                    }
                    .onChange(of: vm.selectedToCurrency) { _, _ in
                        vm.fetchRates()
                    }
                }
                
                HStack {
                    TextField(text: $vm.textFromCurrency) {
                        Text("")
                    }
                    .keyboardType(.numberPad)
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
                    .disabled(true)
                    .keyboardType(.numberPad)
                    .minimumScaleFactor(0.1)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .border(Color.gray, width: 1)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 15)
                
                NavigationLink {
                    DetailsView(vm: DetailsViewModel(exchangesList: vm.exchangesList))
                } label: {
                    Text("Details")
                        .font(.title3)
                }
            }
            .navigationTitle(Text("Currency!"))
        }
    }
}

#Preview {
    CurrenciesListView(vm: CurrenciesListViewModel())
}
