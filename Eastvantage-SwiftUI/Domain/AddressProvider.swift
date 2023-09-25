//
//  AddressProvider.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import Foundation

protocol AddressProvider {
    func fetchAddresses(query: String) async throws -> [Address]
}
