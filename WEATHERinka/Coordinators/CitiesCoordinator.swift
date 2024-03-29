//
//  CitiesCoordinator.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import UIKit

protocol CitiesCoordinatorProtocol: Coordinator {
    
    var parentCoordinator: WeatherCoordinatorProtocol { get }
    func comeBackFromCities()
    
}

final class CitiesCoordinator: CitiesCoordinatorProtocol {
    
    private(set) var parentCoordinator: WeatherCoordinatorProtocol
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(parentCoordinator: WeatherCoordinatorProtocol, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        print("CitiesCoordinator Start")
        let citiesViewModel = CitiesViewModel(coordinator: self)
        let citiesViewController = CitiesViewController(viewModel: citiesViewModel)
        navigationController.pushViewController(citiesViewController, animated: true)
    }
    
    func comeBackFromCities() {
        navigationController.popViewController(animated: true)
        parentCoordinator.childDidFinish(childCoordinator: self)
    }
    
    deinit {
        print("CitiesCoordinator deinit")
    }
    
    
}
