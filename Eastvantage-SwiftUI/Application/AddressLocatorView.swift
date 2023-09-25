//
//  AddressListView.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import MapKit
import SwiftUI

struct AddressLocatorView: View {
    @StateObject var viewModel: AddressLocatorViewModel
    
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.83834587046632,
            longitude: 14.254053016537693),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03))
    
    var body: some View {
        NavigationStack {
            switch(viewModel.state) {
            case .error(let message):
                Text(message)
            case .noData:
                Text("Type an address in the search filed above")
            case .loading:
                ProgressView()
            case .list(let addresses):
                List(addresses, id: \.id) { address in
                    Button(action: {
                        mapRegion = address.region
                    }) {
                        Text(address.title)
                    }
                }
                Map(coordinateRegion: $mapRegion)
                    .edgesIgnoringSafeArea(.all)
                    .border(.black)
            }
        }
        .searchable(text: $viewModel.searchedQuery, prompt: "Enter address here")
    }
}
