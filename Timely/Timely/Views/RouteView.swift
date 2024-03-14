//
//  RouteView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 11/03/2024.
//

import SwiftUI

struct RouteView: View {
    
    let origin:String
    let destination:String
    let route:[String]
    let type:String
    @State var distance = 0.0
    @State var time = 0.0
    
    func calculateCumulativeValues(for route: [String]) -> (distance: Double, time: Double)? {
        var cumulativeDistance: Double = 0.0
        var cumulativeTime: Double = 0.0
        
        guard route.count > 1 else {
            // If there's only one station in the route, no cumulative values to calculate
            return nil
        }
        
        for i in 0..<(route.count - 1) {
            let currentStation = stationDictionary[route[i]]?.name as? String ?? ""
            let nextStation = stationDictionary[route[i+1]]?.name as? String ?? ""
            
            // Find the current station in the stationArray
            guard let currentStationInfo = stationArray.first(where: { ($0[0] as? String) == currentStation }) else {
                // Unable to find information for the current station
                return nil
            }
            
            // Find the connection between the current station and the next station
            guard let connections = currentStationInfo[safe: 3] as? [[Any]] else {
                // Unable to find connections for the current station
                return nil
            }
            
            guard let connection = connections.first(where: { ($0[0] as? String) == nextStation }) else {
                // Unable to find a connection to the next station
                return nil
            }
            
            // Extract distance and time from the connection
            guard let distance = connection[safe: 1] as? Double, let time = connection[safe: 2] as? Double else {
                // Unable to extract distance or time from the connection
                return nil
            }
            
            // Update cumulative distance and time
            for station in stationArray {
                if let name = station[0] as? String, name == currentStation {
                    if let connections = station[3] as? [[Any]] {
                        for stop in connections {
                            if let stopName = stop[0] as? String, stopName == nextStation {
                                if let distance = stop[1] as? Double, let time = stop[2] as? Double {
                                    cumulativeDistance += distance
                                    cumulativeTime += time
                                }
                            }
                        }
                    }
                }
            }
        }
        print(cumulativeDistance, cumulativeTime)
        time = cumulativeTime
        distance = cumulativeDistance
        return (cumulativeDistance, cumulativeTime)
    }

    
    var body: some View {
        VStack {
            HStack {
                Text(type)
                    .font(Font.custom("London Tube", size: 34))
                    .multilineTextAlignment(.leading)
                    .padding(.leading)  // Apply here for the heading
                    .foregroundColor(Color(.white))
                
                Spacer()
                
                if let cumulativeValue = calculateCumulativeValues(for: route) {
                    if type == "Fastest" {
                        if cumulativeValue.time.rounded() > 60 {
                            Text("\(Int(cumulativeValue.time.rounded())) mins")
                                .font(Font.custom("London Tube", size: 34))
                                .multilineTextAlignment(.trailing)
                                .padding(.leading)  // Apply here for the heading
                                .foregroundColor(Color(.white))
                        }
                        else {
                            Text("\(Int(cumulativeValue.time.rounded())) mins")
                                .font(Font.custom("London Tube", size: 34))
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing)  // Apply here for the heading
                                .foregroundColor(Color(.white))
                        }
                    }
                    else if type == "Shortest"{
                        Text("\(String(format: "%.1f", cumulativeValue.distance)) km")
                            .font(Font.custom("London Tube", size: 34))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing)  // Apply here for the heading
                            .foregroundColor(Color(.white))
                    }
                }
            }
            .padding(.bottom)
            .background(Color("johnstblue"))
            HStack {
                ScrollView {
                    VStack (alignment: .leading){
                        Text(stationDictionary[route.first ?? ""]?.name as! String)
                            .font(Font.custom("London Tube", size: 30))
                            .padding(.top, 5)
                        ForEach (route, id: \.self) { stop in
                            if stop == route.first || stop == route.last {
                                
                            }
                            else {
                                HStack{
                                    Image(systemName: "circle")
                                        .bold()
                                    
                                    Text(stationDictionary[stop]?.name as! String)
                                        .font(Font.custom("London Tube", size: 18))
                                        .padding(.top, 5)
                                        .padding(.bottom, 5)
                                    VStack (alignment: .center){
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 17), spacing: 17)]) {
                                            ForEach(stationArray.indices, id: \.self) { index in
                                                let stationInfo = stationArray[index]
                                                if let stationInfo = stationInfo as? [Any],
                                                   let name = stationInfo[0] as? String,
                                                   let lines = stationInfo[1] as? [String] {
                                                    if name == stationDictionary[stop]?.name as! String {
                                                        ForEach(lines, id: \.self) { line in
                                                            Text(ShortName(line))
                                                                .frame(width: 24)
                                                                .foregroundColor(.white)
                                                                .padding(.vertical, 7)
                                                                .padding(.horizontal, 4)
                                                                .background(Color(GetColour(name: line)))
                                                                .cornerRadius(5)
                                                                .font(Font.custom("London Tube", size: 9))
                                                                .frame(maxWidth: .infinity)
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                        }.padding(.leading, 10)
                                            .frame(maxWidth: .infinity)
                                    }
                                    
                                }
                            }
                        }
                        if route.count == 2 {
                            HStack {
                                Image(systemName: "circle")
                                    .bold()
                                    .padding(.leading)
                                
                                Text("No stops")
                                    .font(Font.custom("London Tube", size: 18))
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                            }
                        }
                        HStack {
                            Text(stationDictionary[route.last ?? ""]?.name as? String ?? "")
                                .font(Font.custom("London Tube", size: 30))
                            Spacer()
                            Text("£3.50")
                                .font(Font.custom("London Tube", size: 30))
                                .padding(.trailing)
                        }
                    }
                    .padding(.leading)
                }
                Spacer()
            }
            
            
            
            Spacer()
        }
        .background(Color(.grey10))
    }
}

// Extension to safely access elements in an array by index
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

