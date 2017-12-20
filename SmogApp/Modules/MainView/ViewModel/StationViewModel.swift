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
    
    private var nearestStation:Station?{
        didSet{
            guard let station = nearestStation, let actualCity = station.city, let actualId = actualCity.id else{
                return
            }
            if actualCityId != actualId{
                actualCityId = actualId
            }
        }
    }
    private var actualCityId = 0{
        didSet {
            stationsOfActualCity = stationsArray.filter{ $0.city?.id == actualCityId}
        }
    }
    
    private var stationsOfActualCity = [Station]()
    
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
            }

        }
    }
    
    func getActualIndexOf(station:Station, completion: @escaping (_ result:AirIndex) -> Void){
        guard let stationId = station.id else{
            return
        }
        
        client.getIndexOfStation(id: stationId) { (result) in
            switch result {
            case .success(let getAirIndexResult):
                guard let airIndex = getAirIndexResult else { return }
                completion(airIndex)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func tracingLocation(_ currentLocation: CLLocation) {
        self.lastLocation = currentLocation
    }
    
    func numberOfStationForActualCity() -> Int {
        return stationsOfActualCity.count
    }
    
    func stationNameToDisplay(for indexPath: IndexPath) -> String {
        if let stationName = stationsOfActualCity[indexPath.row].stationName{
            return stationName
        }else{
            return ""
        }
    }
    
    func getAirIndex(for indexPath: IndexPath, completion: @escaping (_ result:AirIndex) -> Void) {
        let station = stationsOfActualCity[indexPath.row]
        getActualIndexOf(station: station, completion: { (airIndex) in
            completion(airIndex)
        })
    }
    
}



