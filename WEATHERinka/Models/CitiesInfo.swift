//
//  CitiesInfo.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 16.01.2024.
//

struct CitiesInfo: Decodable {
    
    let results: [CityInfo]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
}
