//
//  CitiesViewModel.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

protocol CitiesViewModelProtocol {
    
    func comeBackFromCities()
    func getCitiesInfo(cityNameToAutocomplete: String)
    
}

final class CitiesViewModel: CitiesViewModelProtocol {
    
    private let coordinator: CitiesCoordinatorProtocol
    private let locationManager = LocationManager()
    private let networkManager = NetworkManager()
    
    init(coordinator: CitiesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getCitiesInfo(cityNameToAutocomplete: String) {
        locationManager.startSingleLocationUpdate { [weak self] (location) in
            guard let location = location else { print("Location is not provided"); return }
            print("Latitude: \(location.latitude), Longitude: \(location.longitude)")
            let userLocation = (location.latitude, location.longitude)
            self?.networkManager.getCitiesInfo(cityNameToAutocomplete: "Almet", userLocation: userLocation) { result in
                switch result {
                case .success(let citiesInfo):
                    print(citiesInfo)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func comeBackFromCities() {
        coordinator.comeBackFromCities()
    }
    
    deinit {
        print("CitiesViewModel deinit")
    }
}
