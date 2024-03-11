//
//  stationNode.swift
//  Timely
//
//  Created by Rishi Thiahulan on 25/01/2024.
//

import Foundation

// Struct to represent a station
struct Station {
    let name: String
    let nameID: String
    var connectedTo: [String: Double] // [Connected station nameID: Weight]
    var servedBy: [String] // Underground lines that service the station

    init(name: String, nameID: String, servedBy: [String]) {
        self.name = name
        self.nameID = nameID
        self.connectedTo = [:]
        self.servedBy = servedBy
    }

    // Function to add a connection to another station with a specified weight
    mutating func addConnection(to stationNameID: String, withWeight weight: Double) {
        connectedTo[stationNameID] = weight
    }
}
