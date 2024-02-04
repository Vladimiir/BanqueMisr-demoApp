//
//  BanqueMisr_demoAppApp.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import SwiftUI

@main
struct BanqueMisr_demoAppApp: App {
    
    // TODO: do this logic in any external model?
    @StateObject var vm = CurrenciesListViewModel()
    
    var body: some Scene {
        WindowGroup {
            if vm.isLoaded {
                CurrenciesListView(vm: vm)
            } else {
                LoadingView(vm: vm)
            }
        }
    }
}
