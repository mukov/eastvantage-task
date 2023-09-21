//
//  AddressListViewModel.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import Foundation

enum AddressListViewState {
    case noData
    case error(String)
    case list([Address])
}

class AddressListViewModel: ObservableObject {
    private var addressProvider: AddressProvider
    
    @Published var state: AddressListViewState = .noData
    
    init(addressProvider: AddressProvider) {
        self.addressProvider = addressProvider
    }
}
