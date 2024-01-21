//
//  CityItem.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 16.01.2024.
//

import Foundation

struct CityItem: Hashable {
    
    private(set) var cityName: String
    private let latitude: Double
    private let longitude: Double
    
    init(cityName: String, latitude: Double, longitude: Double) {
        self.cityName = cityName
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(city: City) {
        self.cityName = city.address.joined(separator: " ")
        self.latitude = city.latitude
        self.longitude = city.longitude
    }
    
}
