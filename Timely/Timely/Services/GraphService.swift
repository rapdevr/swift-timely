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
    var ProcessedRoute:[[Any]] = []

    init() {
        self.stations = [:]
    }

    // Function to add a station to the graph
    func AddStation(_ station: Station) {
        stations[station.nameID] = station
    }

    // Function to add a connection between two stations with a specified weight
    func AddConnection(from station1ID: String, to station2ID: String, withWeight weight: Double) {
        stations[station1ID]?.addConnection(to: station2ID, withWeight: weight)
        //stations[station2ID]?.addConnection(to: station1ID, withWeight: weight) // Assuming connections are bidirectional
    }
    
    // function to find the shortest path between two stations
    func ShortestPath(from origin: String, to destination: String, passVia: String? = nil, avoidStation: String? = nil) -> [String]? {
        // Dictionary to store distances from origin to each station
        var distances = [String: Double]()
        // Dictionary to store previous station in the shortest path
        var previous = [String: String]()
        // set of unvisited stations
        var unvisited = Set(stations.keys)
        
        // initialize distances to infinity and previous stations to nil
        for stationID in unvisited {
            distances[stationID] = Double.infinity
            previous[stationID] = nil
        }
        distances[origin] = 0
        
        // cumulative distance variable to store the total distance from origin to destination
        
        while !unvisited.isEmpty {
            // get the unvisited station with the least distance
            guard let currentID = unvisited.min(by: { distances[$0]! < distances[$1]! }) else { break }
            
            // if the destination is reached, construct and return the shortest path as an array
            if currentID == destination {
                var path = [destination]
                var prev = currentID
                while let previousStation = previous[prev] {
                    path.append(previousStation)
                    // Accumulate the distance as per the distances dictionary
                    prev = previousStation
                }
                return path.reversed()
            }
            
            // calculate distances to neighbors
            if let currentStation = stations[currentID] {
                for neighbour in currentStation.connectedTo {
                    let neighbourID = neighbour.key
                    
                    // skip if trying to avoid station
                    if let avoidStation = avoidStation, avoidStation == neighbourID {
                        continue
                    }
                    
                    // Instead of a hardcoded value, use the distance from the graph
                    var distanceToNeighbour = distances[currentID]! + neighbour.value
                    
                    // if asked to pass through a station and not met, apply penalty
                    if let passVia = passVia, passVia != neighbourID {
                        let penaltyValue: Double = 1000
                        let stationPenaltyValue = (currentStation.nameID == passVia) ? 0.0 : penaltyValue
                        distanceToNeighbour += stationPenaltyValue
                    }
                    
                    if let neighbourDistance = distances[neighbourID], distanceToNeighbour < distances[neighbourID]! {
                        distances[neighbourID] = distanceToNeighbour
                        previous[neighbourID] = currentID
                    }
                }
            }
            unvisited.remove(currentID)
        }
        
        return nil
    }
    
}
