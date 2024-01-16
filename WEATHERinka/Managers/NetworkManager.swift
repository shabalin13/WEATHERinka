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
    
    func getCitiesInfo(cityNameToAutocomplete: String,
                  userLocation: (latitude: Double, longitude: Double),
                  completionHadler: @escaping (Swift.Result<CitiesInfo, Error>) -> Void)
    
}

final class NetworkManager: NetworkManagerProtocol {
    
    enum NetworkManagerError: Error, LocalizedError {
        case getMapsAccessTokenFailed
        case getCitiesInfoFailed
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
    
    func getCitiesInfo(cityNameToAutocomplete: String, userLocation: (latitude: Double, longitude: Double), completionHadler: @escaping (Result<CitiesInfo, Error>) -> Void) {
        getMapsAccessToken { result in
            switch result {
            case .success(let mapsAccessToken):
                AF.request(NetworkRouter.citiesInfo(mapsAccessToken: mapsAccessToken, cityNameToAutocomplete: cityNameToAutocomplete, userLocation: userLocation)).validate().responseDecodable(of: CitiesInfo.self, queue: .global()) { response in
                    switch response.result {
                    case .success(let citiesInfo):
                        completionHadler(.success(citiesInfo))
                    case .failure(_):
                        completionHadler(.failure(NetworkManagerError.getCitiesInfoFailed))
                    }
                }
            case .failure(let error):
                completionHadler(.failure(error))
            }
        }
    }
    
}
