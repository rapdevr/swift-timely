//
//  GraphConstructor.swift
//  Timely
//
//  Created by Rishi Thiahulan on 14/02/2024.
//

import Foundation
import SwiftUI

// create instances of undergroundGraph for distanc and time
let undergroundGraphDist = UndergroundGraph()
let undergroundGraphTime = UndergroundGraph()
// dictionary to store stations with their normalised name as keys
var stationDictionary = [String: Station]()

class GraphConstructor {
    // function to normalise input, i.e. remove special characters and whitespace.
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
    
    // function to create station objects and populate the station dictionary and graph
    func CreateStations() {
        
        for station in stationArray {
            // Get station name
            let name = station[0] as! String
            // normalise name to use as key
            let nameID = NormaliseInput(name)
            let servedBy = station[1] as! [String]
            
            // create station obj
            let node = Station(name: name, nameID: nameID, servedBy: servedBy)
            // add station to dictionary
            stationDictionary[nameID] = node
            // add node to graph
            undergroundGraphDist.AddStation(node)
            undergroundGraphTime.AddStation(node)
            
            
        }
    }
    
    // function to populate graphs with connections
    func PopulateGraph() {
        for station in stationArray {
            let from:String = station[0] as! String
            
            if let connections = station[3] as? [[Any]] {
                for connection in connections {
                    let to:String = connection[0] as! String
                    // Add connections between stations in both graphs
                    undergroundGraphDist.AddConnection(from: NormaliseInput(from), to: NormaliseInput(to), withWeight: connection[1] as! Double)
                    undergroundGraphTime.AddConnection(from: NormaliseInput(from), to: NormaliseInput(to), withWeight: connection[2] as! Double)
                    
                }
            }
            
        }
    }
    
    // function to build graph by creating stations and adding connections
    func BuildGraph() {
        CreateStations()
        PopulateGraph()
    }
}
