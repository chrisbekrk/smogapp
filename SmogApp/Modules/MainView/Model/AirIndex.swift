//
//  AirIndex.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import Foundation

struct AirIndex: Decodable {
    
    let id: Int?
    let stIndexLevel: IndexLevel?

}

struct IndexLevel: Decodable {
    
    let id: Int?
    let indexLevelName: String?
 
}

