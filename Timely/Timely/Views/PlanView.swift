//
//  PlanView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 15/01/2024.
//

import SwiftUI
import DispatchIntrospection
import CoreData

let context = managedContext

struct PlanView: View {
    // variables to hold destination and origin strings, @State type for dynamic updates
    @State private var destination:String = ""
    @State private var origin:String = ""
    @State private var filteredDestinations: [String] = []
    @State private var filteredOrigins: [String] = []
    @State private var originTap:Bool = false
    @State private var destinationTap:Bool = false
    @State private var intermediate:String = ""
    @State private var fastRoute:Bool = true
    @State private var shortDistRoute:Bool = false
    @State private var isEmpty:Bool = false
    @State private var showingAlert:Bool = false
    @State private var optionalButton:Bool = false
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        ZStack {
            VStack {
                
                            HStack {
                                Text("Plan your journey")
                                    .font(Font.custom("London Tube", size: 32, relativeTo: .largeTitle))
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)  // Apply here for the heading
                                    .foregroundColor(Color(.white))
                                
                                Spacer()
                            }
                            .padding(.bottom)
                            .background(Color("johnstblue"))
                            .padding(.bottom)
                            HStack{
                                VStack {
                                    HStack {
                                        TextField("Origin", text: $origin )
                                            .font(Font.custom("London Tube", size: 18))
                                            .padding([.top, .leading])
                                            .padding(.bottom, 8)
                                            .onTapGesture {
                                                originTap = true
                                            }
                                            .sheet(isPresented: $originTap) {
                                                TextField("Origin", text: $origin )
                                                    .font(Font.custom("London Tube", size: 18))
                                                    .padding([.top, .leading, .bottom])
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color("fieldblue"), lineWidth: 2)
                                                    ).padding()
                                                    .onChange(of: origin) { value in
                                                        filteredOrigins = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                                        
                                                    }
                                                    .presentationDetents([.medium, .large])
                                                
                                                List (filteredOrigins, id:\.self) { station in
                                                    Text(station)
                                                        .font(Font.custom("London Tube", size: 18))
                                                        .onTapGesture {
                                                            origin = station
                                                            originTap = false
                                                        }
                                                }
                                                
                                                Spacer()
                                            }
                                        
                                    }
                                    
                                    HStack {
                                        
                                        Spacer()
                                        Spacer()
                                        
                                        Divider()
                                            .frame(width:200, height: 1)
                                            .overlay(.gray)
                                            .frame(alignment: .center)
                                                      
                                        Spacer()
                                        
                                        Button {
                                            // intermediate value used so no stations are lost during reassigment
                                            intermediate = origin
                                            origin = destination
                                            destination = intermediate
                                        }
                                    label: {
                                        Image(systemName: "arrow.up.arrow.down")
                                            .font(.title3)
                                            .foregroundStyle(Color(.gray))
                                        
                                    }
                                    .padding(.trailing)
                                        
                                    }

                                    
                                    TextField("Destination", text: $destination )
                                        .font(Font.custom("London Tube", size: 18))
                                        .padding([.leading, .bottom])
                                        .padding(.top, 8)
                                        .onTapGesture {
                                            destinationTap = true
                                        }
                                        .sheet(isPresented: $destinationTap) {
                                            TextField("Destination", text: $destination )
                                                .font(Font.custom("London Tube", size: 18))
                                                .padding([.top, .leading, .bottom])
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color("fieldblue"), lineWidth: 2)
                                                ).padding()
                                                .onChange(of: destination) { value in
                                                    filteredDestinations = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                                    
                                                }
                                                .presentationDetents([.medium, .large])
                                            
                                            List (filteredDestinations, id:\.self) { station in
                                                Text(station)
                                                    .font(Font.custom("London Tube", size: 18))
                                                    .onTapGesture {
                                                        destination = station
                                                        destinationTap = false
                                                    }
                                            }
                                            
                                            Spacer()
                                        }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isEmpty ? .red : Color("fieldblue"), lineWidth: 2)
                                ).padding([.trailing, .leading])
                                
                            }
                            
                            HStack{
                                // fastest route toggle
                                Toggle(isOn: $fastRoute) {
                                    Text("Fastest")
                                        .font(Font.custom("London Tube", size: 18))
                                        .foregroundColor(fastRoute ? .white : .gray)
                                }
                                
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(fastRoute ? .gray : .grey10)) // Fill color
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.gray, lineWidth: 2) // Border color
                                        )
                                )
                                .padding(.leading)
                                .toggleStyle(.button)
                                
                                // check if other toggles already enabled, if so disable
                                .simultaneousGesture(TapGesture().onEnded {
                                    if shortDistRoute == true {
                                        shortDistRoute = false
                                    }
                                    else if shortDistRoute == false, fastRoute == true {
                                        shortDistRoute = true
                                    }
                                })
                                
                                // shortest distance route toggle
                                Toggle(isOn: $shortDistRoute) {
                                    Text("Shortest")
                                        .font(Font.custom("London Tube", size: 18))
                                        .foregroundColor(shortDistRoute ? .white : .gray)
                                }
                                
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(shortDistRoute ? .gray : .grey10)) // Fill color
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.gray, lineWidth: 2) // Border color
                                        )
                                )
                                .padding(.leading)
                                .toggleStyle(.button)
                                // check if other toggles already enabled, if so disable
                                .simultaneousGesture(TapGesture().onEnded {
                                    if fastRoute == true {
                                        fastRoute = false
                                    }
                                    else if shortDistRoute == true, fastRoute == false {
                                        fastRoute = true
                                    }
                                })
                                
                                Spacer()
                                
                                // fastest route toggle
                                Button(action: {
                                    optionalButton = true
                                }, label: {
                                    Text("Via/Avoid")
                                        .foregroundStyle(Color.gray)
                                        .underline()
                                        .font(Font.custom("London Tube", size: 18))
                                        .foregroundColor(fastRoute ? .white : .gray)
                                })
                                .sheet(isPresented: $optionalButton) {
                                    TextField("Destination", text: $destination )
                                        .font(Font.custom("London Tube", size: 18))
                                        .padding([.top, .leading, .bottom])
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("fieldblue"), lineWidth: 2)
                                        ).padding()
                                        .onChange(of: destination) { value in
                                            filteredDestinations = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                            
                                        }
                                        .presentationDetents([.medium, .large])

                                    
                                    List (filteredDestinations, id:\.self) { station in
                                        Text(station)
                                            .font(Font.custom("London Tube", size: 18))
                                            .onTapGesture {
                                                destination = station
                                                destinationTap = false
                                            }
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.leading)
                                .toggleStyle(.button)
                                
                                Spacer()
                                
                            }.padding(.top)
                                     
                HStack (alignment: .center){
                                Spacer()
                                Button(action: {
                                    if !origin.isEmpty, !destination.isEmpty {
                                        isEmpty = false
                                        // Toggle the state when the button is clicked
                                        if shortDistRoute == true, let shortestPath = undergroundGraphDist.ShortestPath(from: GraphConstructor().NormaliseInput(origin), to: GraphConstructor().NormaliseInput(destination)) {
                                            print(shortestPath)
                                            print(UndergroundGraph().GenerateRouteOutput(shortestPath))
                                            // Output: Shortest path: ["hammersmithcity", "circle"]
                                        } else if fastRoute == true, let fastestPath = undergroundGraphTime.ShortestPath(from: GraphConstructor().NormaliseInput(origin), to: GraphConstructor().NormaliseInput(destination)) {
                                            print(fastestPath)
                                                print(UndergroundGraph().GenerateRouteOutput(fastestPath))
                                        } else {
                                            print("No path found.")
                                        }
                                    }
                                    else {
                                        showingAlert = true
                                        isEmpty = true
                                    }
                                }) {
                                        Text("Search for a route")
                                            .font(Font.custom("London Tube", size: 22, relativeTo: .largeTitle))
                                            .foregroundColor(.white)
                                            .padding(.vertical, 9)
                                            .padding(.horizontal, 9)
                                            .background(Color(.johnstblue))
                                            .cornerRadius(10)
                                    }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Error"), message: Text("Origin and destination cannot be empty!"), dismissButton: .default(Text("OK")))
                                }
                                .frame(maxWidth: .infinity)
                                Spacer()
                                }
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(.johnstblue))
                                )
                                .padding([.leading, .trailing, .top])
                VStack{
                    HStack{
                        Text("Your past journeys:")
                            .font(Font.custom("London Tube", size: 22, relativeTo: .largeTitle))
                            .foregroundColor(.gray)
                            .padding(.vertical, 9)
                            .padding(.horizontal, 9)
                            .cornerRadius(10)
                            .padding(.leading)
                            .padding(.top, 10)
                        
                        Spacer()
                    }
                }
    
                            
                            Spacer()
            }.background(Color("grey10"))
            
            
        }
    }
}

struct PlanView_Previews: PreviewProvider {
        static var previews: some View {
            PlanView()
        }
    }
