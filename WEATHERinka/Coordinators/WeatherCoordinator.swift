//
//  WeatherCoordinator.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import UIKit

protocol WeatherCoordinatorProtocol: Coordinator {
    
    var parentCoordinator: AppCoordinatorProtocol { get }
    func goToCities()
    func childDidFinish(childCoordinator: Coordinator)
    
}

final class WeatherCoordinator: WeatherCoordinatorProtocol {
    
    private(set) var parentCoordinator: AppCoordinatorProtocol
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(parentCoordinator: AppCoordinatorProtocol, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        print("WeatherCoordinator Start")
        let weatherViewModel = WeatherViewModel(coordinator: self)
        let weatherViewController = WeatherViewController(viewModel: weatherViewModel)
        navigationController.setViewControllers([weatherViewController], animated: false)
    }
    
    deinit {
        print("WeatherCoordinator deinit")
    }
    
    func goToCities() {
        let citiesCoordinator = CitiesCoordinator(parentCoordinator: self, navigationController: navigationController)
        childCoordinators.append(citiesCoordinator)
        citiesCoordinator.start()
    }
    
    func childDidFinish(childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
}

