//
//  GraphConstructor.swift
//  Timely
//
//  Created by Rishi Thiahulan on 14/02/2024.
//

import Foundation
import SwiftUI

var temp:String = ""

func normalise(input:String) -> String {
    var tempStr:String = ""
    tempStr = input.replacingOccurrences(of: "\'", with: "")
    tempStr = input.replacingOccurrences(of: " ", with: "")
    tempStr = input.replacingOccurrences(of: "&", with: "")
    tempStr = input.replacingOccurrences(of: "-", with: "")
    return tempStr
}

func CreateStations() {
    for station in undergroundStations {
        // normalise station name
        temp = station.lowercased()
        temp = normalise(input: temp)
        
        // idenfify which lines serve station
        
    }
}
/*
let undergroundGraph = UndergroundGraph()

// Adding stations to the graph
undergroundGraph.addStation(hammersmithCity)
undergroundGraph.addStation(bakerstreet)

// Adding connections between stations
undergroundGraph.addConnection(from: "hammersmithcity", to: "bakerstreet", withWeight: 5)
undergroundGraph.addConnection(from: "waterloo", to: "bakerstreet", withWeight: 5)


print(undergroundGraph.stations["bakerstreet"]?.connectedTo) // Output: Optional(["circle": 5])
*/
