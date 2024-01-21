//
//  CitiesViewModel.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import RxSwift
import Dispatch

protocol CitiesViewModelProtocol {
    
    var cityItems: PublishSubject<[CityItem]> { get }
    
    func comeBackFromCities()
    func getCities(cityNameToAutocomplete: String)
    
}

final class CitiesViewModel: CitiesViewModelProtocol {
    
    private let coordinator: CitiesCoordinatorProtocol
    private let locationManager = LocationManager()
    private let networkManager = NetworkManager()
    
    private(set) var cityItems = PublishSubject<[CityItem]>()
    
    init(coordinator: CitiesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getCities(cityNameToAutocomplete: String) {
        locationManager.startSingleLocationUpdate { [weak self] (location) in
            guard let self = self else { return }
            guard let location = location else { print("Location is not provided"); return }
            print("Latitude: \(location.latitude), Longitude: \(location.longitude)")
            let userLocation = (location.latitude, location.longitude)
            self.networkManager.getCities(cityNameToAutocomplete: cityNameToAutocomplete, userLocation: userLocation) { result in
                switch result {
                case .success(let cities):
                    let cityItems = self.createCityItems(cities: cities)
                    DispatchQueue.main.async {
                        self.cityItems.onNext(cityItems)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func createCityItems(cities: Cities) -> [CityItem] {
        let cityItems = cities.results.map { city in
            CityItem(city: city)
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
