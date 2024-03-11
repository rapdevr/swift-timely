//
//  GraphConstructor.swift
//  Timely
//
//  Created by Rishi Thiahulan on 14/02/2024.
//

import Foundation
import SwiftUI

let undergroundGraphDist = UndergroundGraph()
let undergroundGraphTime = UndergroundGraph()
var stationDictionary = [String: Station]()

class GraphConstructor {
    func NormaliseInput(_ input:String) -> String {
        var tempStr:String = ""
        tempStr = input
        tempStr = tempStr.lowercased()
        tempStr = tempStr.replacingOccurrences(of: "\'", with: "")
        tempStr = tempStr.replacingOccurrences(of: " ", with: "")
        tempStr = tempStr.replacingOccurrences(of: "&", with: "")
        tempStr = tempStr.replacingOccurrences(of: "-", with: "")
        tempStr = tempStr.replacingOccurrences(of: ".", with: "")
        return tempStr
    }
    
    func CreateStations() {
        
        for station in stationArray {
            // Get station name
            let name = station[0] as! String
            let nameID = NormaliseInput(name)
            let servedBy = station[1] as! [String]
            
            let node = Station(name: name, nameID: nameID, servedBy: servedBy)
            stationDictionary[nameID] = node
            undergroundGraphDist.AddStation(node)
            undergroundGraphTime.AddStation(node)
            
            
        }
    }
    
    func PopulateGraph() {
        for station in stationArray {
            let from:String = station[0] as! String
            
            if let connections = station[3] as? [[Any]] {
                for connection in connections {
                    let to:String = connection[0] as! String
                    // Check if the array has at least 2 elements
                    undergroundGraphDist.AddConnection(from: NormaliseInput(from), to: NormaliseInput(to), withWeight: connection[1] as! Double)
                    undergroundGraphTime.AddConnection(from: NormaliseInput(from), to: NormaliseInput(to), withWeight: connection[2] as! Double)
                    
                }
            }
            
        }
    }
    
    func BuildGraph() {
        CreateStations()
        PopulateGraph()
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
