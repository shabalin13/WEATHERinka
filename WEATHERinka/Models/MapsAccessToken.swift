//
//  MapsAccessToken.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 16.01.2024.
//

struct MapsAccessToken: Decodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "accessToken"
    }
    
}
