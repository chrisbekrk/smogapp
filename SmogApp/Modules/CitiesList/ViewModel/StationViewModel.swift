//
//  StationViewModel.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import Foundation
import CoreLocation

protocol StationViewModelDelegate:class {
    func setNewData(nearestStation: Station)
}

class StationViewModel:LocationServiceDelegate{
    
    weak var delegate: StationViewModelDelegate?
    
    private let client = SmogClient()
    
    private var lastLocation = CLLocation(latitude: 52.0610324, longitude: 19.9244222){
        didSet {
            getTheNearest(currentLocation: lastLocation)
        }
    }
    
    private var stationsArray = [Station](){
        didSet {
            getTheNearest(currentLocation: lastLocation)
        }
    }
    
    private var nearestStation:Station?
    
    init(){
        LocationManager.sharedInstance.delegate = self
        getAllStations()
    }
    
    func getAllStations(){

        client.getAllStations { [weak self] (result) in
            switch result {
            case .success(let getAllStationResult):
                guard let getAllStationResults = getAllStationResult else { return }
                self?.stationsArray = getAllStationResults
            //print(getAllStationResults)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    
    func getTheNearest(currentLocation: CLLocation){
        if stationsArray.count > 0 {
            var closestStation = stationsArray.first
            let distance = 9999.99
            for station in stationsArray{
                var actualStation = station
                if let actualStationCords = actualStation.cords{
                    
                    let distanceActual = currentLocation.distance(from: actualStationCords)
                    if distance > distanceActual{
                        closestStation = station
                    }
                    
                }
            }
            
            guard let station = closestStation else {
                return
            }
            if station.id != nearestStation?.id{
                nearestStation = station
                delegate?.setNewData(nearestStation: station)
                getActualIndexOf(station: station)
            }

        }
    }
    
    func getActualIndexOf(station:Station){
        guard let stationId = station.id else{
            return
        }
        client.getIndexOfStation(id: stationId) { [weak self] (result) in
            switch result {
            case .success(let getAirIndexResult):
                guard let airIndex = getAirIndexResult else { return }
                print(airIndex)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func tracingLocation(_ currentLocation: CLLocation) {
        self.lastLocation = currentLocation
    }
    
    
}



