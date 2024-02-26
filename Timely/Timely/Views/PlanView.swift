//
//  PlanView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 15/01/2024.
//

import SwiftUI
import SwiftUIX

struct PlanView: View {
    // variables to hold destination and origin strings, @State type for dynamic updates
    @State private var destination:String = ""
    @State private var origin:String = ""
    @State private var filteredDestinations: [String] = []
    @State private var filteredOrigins: [String] = []
    @State private var originTap:Bool = false
    @State private var destinationTap:Bool = false
    @State private var intermediate:String = ""
    @State private var cheapRoute:Bool = false
    @State private var fastRoute:Bool = false
    @State private var shortDistRoute:Bool = false
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {

        VStack {
            HStack {
                Text("Plan a journey:")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.leading)  // Apply here for the heading
                    .foregroundColor(colorScheme == .light ? Color(red: 0.0, green: 0.098, blue: 0.655) : .white)	
                
                Spacer()
            }
            HStack{
                VStack {
                    TextField("Where From?", text: $origin    )
                        .padding([.top, .leading, .bottom])
                        .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
                        ).padding([.top, .leading])
                        .onTapGesture {
                            originTap = true
                            }
                        .sheet(isPresented: $originTap) {
                            TextField("Where To?", text: $origin )
                                .padding([.top, .leading, .bottom])
                                .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
                                ).padding()
                                .onChange(of: origin) { value in
                                    filteredOrigins = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                    
                                }
                                .presentationDetents([.medium, .large])
                            
                            List (filteredOrigins, id:\.self) { station in
                                Text(station)
                                    .onTapGesture {
                                        origin = station
                                        originTap = false
                                    }
                            }
                            
                            Spacer()
                        }
                    
                    TextField("Where To?", text: $destination )
                        .foregroundStyle(.white)
                        .padding([.top, .leading, .bottom])
                        .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
                        ).padding([.bottom, .leading])
                        .onTapGesture {
                            destinationTap = true
                            }
                        .sheet(isPresented: $destinationTap) {
                            TextField("Where To?", text: $destination )
                                .padding([.top, .leading, .bottom])
                                .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
                                ).padding()
                                .onChange(of: destination) { value in
                                    filteredDestinations = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                    
                                }
                                .presentationDetents([.medium, .large])
                            
                            List (filteredDestinations, id:\.self) { station in
                                Text(station)
                                    .onTapGesture {
                                        destination = station
                                        destinationTap = false
                                    }
                            }
                                
                            Spacer()
                        }
                }
                
                VStack {
                    
                    Button {
                        // intermediate value used so no stations are lost during reassigment
                        
                        intermediate = origin
                        origin = destination
                        destination = intermediate
                    }
                    label: {
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                            .font(.largeTitle)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white)
                            .accentColor(.green)

                    }
                    .padding(.trailing)
                }
            }
            .background(Rectangle()
                .foregroundStyle(colorScheme == .dark ? Color.black : /*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                .cornerRadius(10))
            
            HStack{
                // cheapest route toggle
                Toggle(isOn: $cheapRoute) {
                    Image(systemName: "coloncurrencysign")
                        .font(.largeTitle)
                }
                .toggleStyle(.button)
                .tint(.green)
                .padding(.leading)
                // check if other toggles already enabled, if so disable
                .simultaneousGesture(TapGesture().onEnded {
                    if shortDistRoute == true || fastRoute == true {
                        shortDistRoute = false
                        fastRoute = false
                    }
                })
                // fastest route toggle
                Toggle(isOn: $fastRoute) {
                    Image(systemName: "clock")
                        .font(.largeTitle)
                }
                .toggleStyle(.button)
                .tint(.orange)
                // check if other toggles already enabled, if so disable
                .simultaneousGesture(TapGesture().onEnded {
                    if cheapRoute == true || shortDistRoute == true {
                        cheapRoute = false
                        shortDistRoute = false
                    }
                })
                // shortest distance route toggle
                Toggle(isOn: $shortDistRoute) {
                    Image(systemName: "arrow.triangle.swap")
                        .font(.largeTitle)
                }
                .toggleStyle(.button)
                .tint(.blue)
                // check if other toggles already enabled, if so disable
                .simultaneousGesture(TapGesture().onEnded {
                    if cheapRoute == true || fastRoute == true {
                        cheapRoute = false
                        fastRoute = false
                    }
                })
                
                Spacer()
                
                Button(action: {
                            // Toggle the state when the button is clicked
                        }) {
                            Text("Go")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green) // Set green tint when clicked
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 2) // Add border
                                )
                        }
                        .padding(.trailing)
                
            }
            
        Spacer()
        }.background(colorScheme == .dark ? Color.black : /*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
        
    }
    
    struct PlanView_Previews: PreviewProvider {
        static var previews: some View {
            PlanView()
        }
    }
}
