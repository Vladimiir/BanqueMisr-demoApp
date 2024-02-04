//
//  CurrenciesListView.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import SwiftUI

struct CurrenciesListView: View {
    
    @StateObject var vm = CurrenciesListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle(Text("Currency!"))
        }
        .task {
            vm.viewWillAppear()
        }
    }
}

#Preview {
    CurrenciesListView()
}
