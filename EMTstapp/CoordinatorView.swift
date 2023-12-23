//
//  CoordinatorView.swift
//  EMTstapp
//
//  Created by ARMBP on 12/18/23.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    @StateObject private var viewModel = ViewModel(networkManager: NetworkManager())
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .main)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(viewModel)
        .environmentObject(coordinator)
        .accentColor(.black)
    }
}

#Preview {
    CoordinatorView()
}
