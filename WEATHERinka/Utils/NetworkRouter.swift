//
//  NetworkRouter.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 16.01.2024.
//

import Foundation
import Alamofire

enum NetworkRouter {
    
    case mapsAccessToken
    case cities(mapsAccessToken: MapsAccessToken, cityNameToAutocomplete: String,
                    userLocation: (latitude: Double, longitude: Double))
    
    var baseURL: URL {
        switch self {
        case .mapsAccessToken, .cities:
            return URL(string: "https://maps-api.apple.com")!
        }
    }
    
    var path: String {
        switch self {
        case .mapsAccessToken:
            return "v1/token"
        case .cities:
            return "v1/searchAutocomplete"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .mapsAccessToken, .cities:
            return .get
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .mapsAccessToken:
            return ["Authorization": "Bearer \(Constants.NetworkManagerConstants.jwtMapKitToken)"]
        case .cities(let mapsAccessToken, _, _):
            return ["Authorization": "Bearer \(mapsAccessToken.token)"]
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .mapsAccessToken:
            return [:]
        case .cities(_, let cityNameToAutocomplete, let userLocation):
            return ["q": cityNameToAutocomplete,
                    "userLocation": "\(userLocation.latitude),\(userLocation.longitude)",
                    "lang": Constants.NetworkManagerConstants.lang,
                    "includePoiCategories": Constants.NetworkManagerConstants.includePoiCategories,
                    "resultTypeFilter": Constants.NetworkManagerConstants.resultTypeFilter]
        }
    }
    
}

extension NetworkRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(parameters, into: request)
        
        print(request)
        
        return request
    }

}
