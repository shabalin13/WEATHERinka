//
//  WeatherViewModel.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

protocol WeatherViewModelProtocol {
    
    func goToCities()
    
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    private var coordinator: WeatherCoordinatorProtocol
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func goToCities() {
        coordinator.goToCities()
    }
    
    deinit {
        print("WeatherViewModel deinit")
    }
}
