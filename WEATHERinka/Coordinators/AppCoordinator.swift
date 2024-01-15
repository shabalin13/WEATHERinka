//
//  AppCoordinator.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        print("AppCoordinator Start")
        
        let navigationController = UINavigationController()
        
        let weatherCoordinator = WeatherCoordinator(parentCoordinator: self, navigationController: navigationController)
        childCoordinators.append(weatherCoordinator)
        weatherCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    deinit {
        print("AppCoordinator deinit")
    }
    
}
