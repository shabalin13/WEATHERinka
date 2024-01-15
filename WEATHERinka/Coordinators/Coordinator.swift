//
//  Coordinator.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get }
    func start()
    
}
