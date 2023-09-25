//
//  AdresseGouvAddressProvider.swift
//  Eastvantage-SwiftUI
//
//  Created by mukov on 21.09.23.
//

import Foundation

enum ServiceError: Error {
    case badUrl
}

class AdresseGouvAddressProvider: AddressProvider {
    private let apiUrl = "https://api-adresse.data.gouv.fr/search/"
    
    func fetchAddresses(query: String) async throws -> [Address] {
        guard var urlComponents = URLComponents(string: "\(apiUrl)") else {
            throw ServiceError.badUrl
        }
        
        urlComponents.queryItems = [
            URLQueryItem(
                name: "q",
                value: query)]
        
        guard let url = urlComponents.url else {
            throw ServiceError.badUrl
        }
        
        print("--> Fetching: \(url.formatted())")
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let jsonDecoder = JSONDecoder()
        let jsonResponse = try jsonDecoder.decode(JSONResponse.self, from: data)
        
        let addresses = jsonResponse.features.compactMap({ feature in
            return Address(
                id: feature.properties.id,
                title: feature.properties.label,
                latitude: feature.geometry.coordinates[1],
                longitude: feature.geometry.coordinates[0])
        })
        
        return addresses
    }
    
    private struct JSONResponse: Decodable {
        let features: [JSONFeature]
    }
    
    private struct JSONFeature: Decodable {
        let geometry: JSONFeatureGeometry
        let properties: JSONFeatureProperties
    }
    
    private struct JSONFeatureGeometry: Decodable {
        let coordinates: [Float]
    }
    
    private struct JSONFeatureProperties: Decodable {
        let id: String
        let label: String
        // TODO: should get the compiled address instead
    }
}
