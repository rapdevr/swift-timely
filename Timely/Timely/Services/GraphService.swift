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
    func ShortestPath(from origin:String, to destination:String, passVia: String? = nil, avoidStation: String? = nil) -> [String]? {
        // Dictionary to store distances from origin to each station
        var distances = [String:Double]()
        // Dictionary to store previous station in the shortest path
        var previous = [String:String]()
        // set of unvisited stations
        var unvisited = Set(stations.keys)
        
        // initalise distances to infinity and previous stations to nil
        for stationID in unvisited {
            distances[stationID] = Double.infinity
            previous[stationID] = nil
        }
        distances[origin] = 0
        
        while !unvisited.isEmpty {
            // get the unvisited station with least distance
            guard let currentID = unvisited.min(by: { distances[$0]! < distances[$1]!}) else { break }
            
            // if the destination is reached, contruct and return shortest path as array
            if currentID == destination {
                var path = [destination]
                var prev = currentID
                while let previousStation = previous[prev] {
                    path.append(previousStation)
                    prev = previousStation
                }
                return path.reversed()
            }
            
            // calc distances to neighbours
            if let currentStation = stations[currentID] {
                for neighbour in currentStation.connectedTo {
                    let neighbourID = neighbour.key
                    
                    // skip if trying to avoid station
                    if let avoidStation = avoidStation, avoidStation == neighbourID {
                        continue
                    }
                    
                    var distanceToNeighbour = distances[currentID]! + neighbour.value
                    
                    // if asked to pass through a station, and not met, apply penalty.
                    if let passVia = passVia, passVia != neighbourID {
                        let penaltyValue:Double = 1000
                        let stationPenaltyValue = (currentStation.nameID == passVia) ? 0.0 : penaltyValue
                        distanceToNeighbour += stationPenaltyValue
                    }
                    
                    if let neighbourDistance = distances[neighbourID] ,distanceToNeighbour < distances[neighbourID]! {
                        distances[neighbourID] = distanceToNeighbour
                        previous[neighbourID] = currentID
                    }
                }
            }
            unvisited.remove(currentID)
        }
        
        return nil
    }
    
    func GenerateRouteOutput(_ route: [String]) -> [[String]] {
        var output: [[String]] = []
        var currentLine: String?
        var currentStart: String?
        
        for i in 0..<route.count - 1 {
            var currentStation = route[i]
            if let station = stationDictionary[currentStation] {
                currentStation = station.name
            }
            var nextStation = route[i + 1]
            if let station = stationDictionary[nextStation] {
                nextStation = station.name
            }
            
            // Find common lines between the current and next stations
            guard let currentStationData = stationArray.first(where: { ($0.first as? String) == currentStation }),
                  let nextStationData = stationArray.first(where: { ($0.first as? String) == nextStation }) else {
                continue
            }
            
            let commonLines = Set(currentStationData[1] as? [String] ?? []).intersection(nextStationData[1] as? [String] ?? [])
            
            // If there's a change of lines or if it's the first station pair
            if commonLines.isEmpty || currentLine == nil {
                if let line = currentLine, let start = currentStart {
                    // End of a journey on the current line
                    output.append([line, start, currentStation])
                }
                // Start a new journey on the longest continuous common line
                if let longestLine = commonLines.max(by: { line1, line2 in
                    let line1Stations = stationsOnLineBetweenStations(line1, start: currentStation, end: nextStation)
                    let line2Stations = stationsOnLineBetweenStations(line2, start: currentStation, end: nextStation)
                    return line1Stations.count < line2Stations.count
                }) {
                    currentLine = longestLine
                    currentStart = currentStation
                }
            }
        }
        
        // Add the last journey
        if let line = currentLine, let start = currentStart, let end = route.last {
            output.append([line, start, end])
        }
        
        return output
    }

    // Helper function to get the stations on a line between two stations
    func stationsOnLineBetweenStations(_ line: String, start: String, end: String) -> [String] {
        guard let lineIndex = stationArray.firstIndex(where: { ($0.first as? String) == line }),
              let startStationIndex = (stationArray[lineIndex][3] as? [[Any]] ?? []).firstIndex(where: { ($0.first as? String) == start }),
              let endStationIndex = (stationArray[lineIndex][3] as? [[Any]] ?? []).firstIndex(where: { ($0.first as? String) == end }) else {
            return []
        }
        
        let stations = (stationArray[lineIndex][3] as? [[Any]] ?? []).map { ($0.first as? String) ?? "" }
        return Array(stations[startStationIndex...endStationIndex])
    }
}
