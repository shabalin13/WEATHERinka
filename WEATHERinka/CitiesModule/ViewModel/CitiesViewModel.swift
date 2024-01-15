//
//  CitiesViewModel.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

protocol CitiesViewModelProtocol {
    
    func comeBackFromCities()
    
}

final class CitiesViewModel: CitiesViewModelProtocol {
    
    private var coordinator: CitiesCoordinatorProtocol
    
    init(coordinator: CitiesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func comeBackFromCities() {
        coordinator.comeBackFromCities()
    }
    
    deinit {
        print("CitiesViewModel deinit")
    }
}
