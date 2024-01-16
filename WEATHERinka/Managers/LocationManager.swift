//
//  LocationManager.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 16.01.2024.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var locationUpdateHandler: ((CLLocationCoordinate2D?) -> Void)?

    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startSingleLocationUpdate(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        locationUpdateHandler = completion
        locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else {
            locationUpdateHandler?(nil)
            return
        }
        locationUpdateHandler?(location)
        
        locationManager.stopUpdatingLocation()
        locationUpdateHandler = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // print("Location update error: \(error.localizedDescription)")
        // Maybe parse error for showing different results on screen
        
        locationUpdateHandler?(nil)
        
        locationManager.stopUpdatingLocation()
        locationUpdateHandler = nil
    }
}
