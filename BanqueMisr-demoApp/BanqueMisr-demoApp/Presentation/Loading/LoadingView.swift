//
//  LoadingView.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import SwiftUI

struct LoadingView: View {
    
    var vm: CurrenciesListViewModel
    
    init(vm: CurrenciesListViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        HStack {
            Text("Loading")
                .font(.title)
        }
        .task {
            vm.viewWillAppear()
        }
    }
}

