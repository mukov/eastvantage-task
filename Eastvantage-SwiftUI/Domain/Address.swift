//
//  Address.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import Foundation
import MapKit

typealias AddressID = String

struct Address {
    let id: AddressID
    let title: String
    let latitude: Float
    let longitude: Float
}
