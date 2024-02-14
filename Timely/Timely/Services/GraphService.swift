//
//  GraphService.swift
//  Timely
//
//  Created by Rishi Thiahulan on 14/02/2024.
//

import Foundation

// Class to represent the graph of the entire London Underground network
class UndergroundGraph {
    var stations: [String: Station] // [Station nameID: Station]

    init() {
        self.stations = [:]
    }

    // Function to add a station to the graph
    func addStation(_ station: Station) {
        stations[station.nameID] = station
    }

    // Function to add a connection between two stations with a specified weight
    func addConnection(from station1ID: String, to station2ID: String, withWeight weight: Int) {
        stations[station1ID]?.addConnection(to: station2ID, withWeight: weight)
        stations[station2ID]?.addConnection(to: station1ID, withWeight: weight) // Assuming connections are bidirectional
    }
}
