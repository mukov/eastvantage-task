//
//  AddressListView.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import MapKit
import SwiftUI

struct AddressListView: View {
    @StateObject var viewModel: AddressListViewModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.83834587046632,
            longitude: 14.254053016537693),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03)
                    )
    
    var body: some View {
        switch(viewModel.state) {
        case .error(let message):
            Text(message)
        case .noData:
            Text("Type an address in the search filed above")
        case .list(let addresses):
            VStack {
                List(addresses, id: \.id) { address in
                    Text(address.title)
                }
                Map(coordinateRegion: $region)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
