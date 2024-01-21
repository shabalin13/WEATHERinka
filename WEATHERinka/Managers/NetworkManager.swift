//
//  NetworkManager.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 16.01.2024.
//

import Foundation
import Alamofire
import Dispatch

protocol NetworkManagerProtocol {
    
    func getCities(cityNameToAutocomplete: String,
                  userLocation: (latitude: Double, longitude: Double),
                  completionHadler: @escaping (Swift.Result<Cities, Error>) -> Void)
    
}

final class NetworkManager: NetworkManagerProtocol {
    
    enum NetworkManagerError: Error, LocalizedError {
        case getMapsAccessTokenFailed
        case getCitiesFailed
    }
    
    private func getMapsAccessToken(completionHadler: @escaping (Result<MapsAccessToken, Error>) -> Void) {
        AF.request(NetworkRouter.mapsAccessToken).validate().responseDecodable(of: MapsAccessToken.self, queue: .global()) { response in
            switch response.result {
            case .success(let mapsAccessToken):
                completionHadler(.success(mapsAccessToken))
            case .failure(_):
                completionHadler(.failure(NetworkManagerError.getMapsAccessTokenFailed))
            }
        }
    }
    
    func getCities(cityNameToAutocomplete: String, userLocation: (latitude: Double, longitude: Double), completionHadler: @escaping (Result<Cities, Error>) -> Void) {
        getMapsAccessToken { result in
            switch result {
            case .success(let mapsAccessToken):
                AF.request(NetworkRouter.cities(mapsAccessToken: mapsAccessToken, cityNameToAutocomplete: cityNameToAutocomplete, userLocation: userLocation)).validate().responseDecodable(of: Cities.self, queue: .global()) { response in
                    switch response.result {
                    case .success(let cities):
                        completionHadler(.success(cities))
                    case .failure(_):
                        completionHadler(.failure(NetworkManagerError.getCitiesFailed))
                    }
                }
            case .failure(let error):
                completionHadler(.failure(error))
            }
        }
    }
    
}
