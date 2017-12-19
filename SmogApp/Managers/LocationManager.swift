//
//  LocationManager.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationServiceDelegate {
    func tracingLocation(_ currentLocation: CLLocation)
    // func tracingLocationDidFailWithError(_ error: NSError)
}

class LocationManager: NSObject,CLLocationManagerDelegate {
    
    static let sharedInstance: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    
    typealias LocationClosure = ((_ location:CLLocation?,_ error: NSError?)->Void)
    private var locationCompletionHandler: LocationClosure?
    
    private var locationManager: CLLocationManager?
    var lastLocation:CLLocation?
    
    var delegate: LocationServiceDelegate?
    
    deinit {
        destroyLocationManager()
    }
    
    //MARK:- Private Methods
    
    
    private func destroyLocationManager() {
        delegate = nil
        locationManager?.delegate = nil
        locationManager = nil
        lastLocation = nil
    }
    
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
                
            case .authorizedAlways, .authorizedWhenInUse:
                // Location services authorised.
                // Start tracking the user.
                locationManager.startUpdatingLocation()
                
                
            default:
                // Request access for location services.
                // This will call didChangeAuthorizationStatus on completion.
                locationManager.requestWhenInUseAuthorization()
            }
        }
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.distanceFilter = 10
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        // singleton for get last(current) location
        lastLocation = location
        
        // use for real time update location
        updateLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .authorizedAlways, .authorizedWhenInUse:
            // Location services are authorised, track the user.
            locationManager?.startUpdatingLocation()
            
            
        case .denied, .restricted:
            // Location services not authorised, stop tracking the user.
            locationManager?.stopUpdatingLocation()
            
            //currentLocation = nil
            
        default: break
            // Location services pending authorisation.
            // Alert requesting access is visible at this point.
            //currentLocation = nil
        }
    }
    
    // Private function
    fileprivate func updateLocation(_ currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocation(currentLocation)
    }
    
    
}
