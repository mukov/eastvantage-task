//
//  Eastvantage_SwiftUIApp.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import SwiftUI

@main
struct Eastvantage_SwiftUIApp: App {
    let addressProvider = AdresseGouvAddressProvider()
    
    var body: some Scene {
        WindowGroup {
            AddressLocatorView(viewModel: AddressLocatorViewModel(
                addressProvider: addressProvider))
        }
    }
}
