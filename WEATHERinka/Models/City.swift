//
//  City.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 21.01.2024.
//

import Foundation

struct City {
    
    let address: [String]
    let latitude: Double
    let longitude: Double
    
    enum RootKeys: String, CodingKey {
        case address = "displayLines"
        case location
    }
    
    enum LocationKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
}

extension City: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        address = try container.decode([String].self, forKey: .address)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        latitude = try locationContainer.decode(Double.self, forKey: .latitude)
        longitude = try locationContainer.decode(Double.self, forKey: .longitude)
        
    }
}

