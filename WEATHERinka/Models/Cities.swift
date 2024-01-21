//
//  Cities.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 21.01.2024.
//

import Foundation

struct Cities: Decodable {
    
    let results: [City]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
}
