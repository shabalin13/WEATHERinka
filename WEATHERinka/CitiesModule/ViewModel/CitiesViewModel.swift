//
//  CitiesViewModel.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import RxSwift
import Dispatch

protocol CitiesViewModelProtocol {
    
    var cityItems: PublishSubject<CityItems> { get }
    
    func comeBackFromCities()
    func getCitiesInfo(cityNameToAutocomplete: String)
    
}

final class CitiesViewModel: CitiesViewModelProtocol {
    
    private let coordinator: CitiesCoordinatorProtocol
    private let locationManager = LocationManager()
    private let networkManager = NetworkManager()
    
    private(set) var cityItems = PublishSubject<CityItems>()
    
    init(coordinator: CitiesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getCitiesInfo(cityNameToAutocomplete: String) {
        locationManager.startSingleLocationUpdate { [weak self] (location) in
            guard let self = self else { return }
            guard let location = location else { print("Location is not provided"); return }
            print("Latitude: \(location.latitude), Longitude: \(location.longitude)")
            let userLocation = (location.latitude, location.longitude)
            self.networkManager.getCitiesInfo(cityNameToAutocomplete: cityNameToAutocomplete, userLocation: userLocation) { result in
                switch result {
                case .success(let citiesInfo):
                    let cityItems = self.createCityItems(citiesInfo: citiesInfo)
                    DispatchQueue.main.async {
                        self.cityItems.onNext(cityItems)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func createCityItems(citiesInfo: CitiesInfo) -> CityItems {
        let cityItems = citiesInfo.results.map { cityInfo in
            CityItem(cityName: cityInfo.displayLines.joined(separator: " "))
        }
        return cityItems
    }
    
    func comeBackFromCities() {
        coordinator.comeBackFromCities()
    }
    
    deinit {
        print("CitiesViewModel deinit")
    }
}
