//
//  Station.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import Foundation
import CoreLocation

struct Station: Decodable {
    
    let id: Int?
    let stationName: String?
    let gegrLat: String?
    let gegrLon: String?
    let city: City?

    lazy var cords:CLLocation? = makeCords()
    
    private func makeCords() -> CLLocation?{
        guard let latStr = (gegrLat as NSString?) else{
            return nil
        }
        
        guard let longStr = (gegrLon as NSString?) else{
            return nil
        }
        let cords = CLLocation(latitude: latStr.doubleValue, longitude: longStr.doubleValue)
        return cords
    }
    
}
