//
//  AddressLocatorViewModel.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import Foundation
import MapKit

enum AddressLocatorListViewState {
    case noData
    case error(String)
    case loading
    case list([AddressViewData])
}

struct AddressViewData {
    let id: AddressID
    let title: String
    let region: MKCoordinateRegion
    
//    let region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(
//            latitude: 40.83834587046632,
//            longitude: 14.254053016537693),
//        span: MKCoordinateSpan(
//            latitudeDelta: 0.03,
//            longitudeDelta: 0.03))
}

class AddressLocatorViewModel: ObservableObject {
    private var addressProvider: AddressProvider
    
    @Published var state: AddressLocatorListViewState = .noData
    
    init(addressProvider: AddressProvider) {
        self.addressProvider = addressProvider
    }
    
    var searchedQuery: String = "" {
        didSet {
            searchAddress(query: searchedQuery)
        }
    }
    
    func searchAddress(query: String) {
        if case .loading = state {
            return
        }
        
        state = .loading
        
        Task { @MainActor in
            do {
                let addresses = try await addressProvider.fetchAddresses(query: query)
                
                if addresses.count > 0 {
                    let addressViewData = addresses.compactMap({ address in
                        let center = CLLocationCoordinate2D(latitude: Double(address.latitude), longitude: Double(address.longitude))
                        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                        
                        return AddressViewData(
                            id: address.id,
                            title: address.title,
                            region: region)
                    })
                    
                    state = .list(addressViewData)
                }
                else {
                    state = .noData
                }
            }
            catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
