//
//  PlanView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 15/01/2024.
//

import SwiftUI
import DispatchIntrospection
import SwiftData

struct PlanView: View {
    // variables to hold destination and origin strings, @State type for dynamic updates
    @Environment(\.modelContext) private var context
    @Query private var items: [JourneyItem]

    @State private var destination:String = ""
    @State private var origin:String = ""
    @State private var filteredDestinations: [String] = []
    @State private var filteredOrigins: [String] = []
    @State private var originTap:Bool = false
    @State private var destinationTap:Bool = false
    @State private var intermediate:String = ""
    @State private var isFast:Bool = true
    @State private var isShortest:Bool = false
    @State private var isFewestChange: Bool = false
    @State private var via:String = ""
    @State private var avoid:String = ""
    @State private var isEmpty:Bool = false
    @State private var showingAlert:Bool = false
    @State private var optionalButton:Bool = false
    @State private var isPressed: Bool = false
    @State private var path: [String] = []
    @State private var type: String = ""
    @State private var isAvoid: Bool = false
    @State private var isVia: Bool = false
    
    func AddJourney() {
        let journey = JourneyItem(origin, destination, isFast, isShortest, isFewestChange, via, avoid)
        context.insert(journey)
        
    }

    
    var body: some View {
        NavigationView {
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
                        Toggle(isOn: $isFast) {
                            Text("Fastest")
                                .font(Font.custom("London Tube", size: 18))
                                .foregroundColor(isFast ? .white : .gray)
                        }
                        
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(isFast ? .gray : .grey10)) // Fill color
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 2) // Border color
                                )
                        )
                        .padding(.leading)
                        .toggleStyle(.button)
                        
                        // check if other toggles already enabled, if so disable
                        .simultaneousGesture(TapGesture().onEnded {
                            if isShortest == true {
                                isShortest = false
                            }
                            else if isShortest == false, isFast == true {
                                isShortest = true
                            }
                        })
                        
                        // shortest distance route toggle
                        Toggle(isOn: $isShortest) {
                            Text("Shortest")
                                .font(Font.custom("London Tube", size: 18))
                                .foregroundColor(isShortest ? .white : .gray)
                        }
                        
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(isShortest ? .gray : .grey10)) // Fill color
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 2) // Border color
                                )
                        )
                        .padding(.leading)
                        .toggleStyle(.button)
                        // check if other toggles already enabled, if so disable
                        .simultaneousGesture(TapGesture().onEnded {
                            if isFast == true {
                                isFast = false
                            }
                            else if isShortest == true, isFast == false {
                                isFast = true
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
                                .foregroundColor(isFast ? .white : .gray)
                        })
                        .sheet(isPresented: $optionalButton) {
                            TextField("Via", text: $via )
                                .font(Font.custom("London Tube", size: 18))
                                .padding([.top, .leading, .bottom])
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("fieldblue"), lineWidth: 2)
                                ).padding([.leading, .trailing, .top])
                                .onTapGesture {
                                    isVia = true
                                }
                                .onChange(of: via) { value in
                                    filteredDestinations = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                    
                                }
                            
                            TextField("Avoid", text: $avoid )
                                .font(Font.custom("London Tube", size: 18))
                                .padding([.top, .leading, .bottom])
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("fieldblue"), lineWidth: 2)
                                ).padding([.leading, .trailing])
                                .onTapGesture {
                                    isAvoid = true
                                }
                                .onChange(of: avoid) { value in
                                    filteredDestinations = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                    
                                }
                            
                            List (filteredDestinations, id:\.self) { station in
                                Text(station)
                                    .font(Font.custom("London Tube", size: 18))
                                    .onTapGesture {
                                        if isAvoid {
                                            avoid = station
                                            
                                        }
                                        else {
                                            via = station
                                        }
                                    }
                            }
                            
                            Spacer()
                        }
                        .padding(.leading)
                        .toggleStyle(.button)
                        .presentationDetents([.medium, .large])
                        
                        Spacer()
                        
                    }.padding(.top)
                    
                    HStack (alignment: .center){
                        Spacer()
                        Button(action: {
                            if !origin.isEmpty, !destination.isEmpty {
                                isPressed = true
                                isEmpty = false
                                if isShortest, let shortestPath = undergroundGraphDist.ShortestPath(from: GraphConstructor().NormaliseInput(origin), to: GraphConstructor().NormaliseInput(destination), passVia: via, avoidStation: avoid) {
                                    path = shortestPath
                                    type = "Shortest"
                                    AddJourney()
                                } else if isFast, let fastestPath = undergroundGraphTime.ShortestPath(from: GraphConstructor().NormaliseInput(origin), to: GraphConstructor().NormaliseInput(destination), passVia: via, avoidStation: avoid) {
                                    path = fastestPath
                                    type = "Fastest"
                                    AddJourney()
                                } else {
                                    print("No path found.")
                                }
                            } else {
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
                                .frame(maxWidth: .infinity)
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Origin and destination cannot be empty!"), dismissButton: .default(Text("OK")))
                        }
                        Spacer()
                    }
                    .background(
                        NavigationLink(destination: RouteView(origin: origin, destination: destination, route: path, type: type), isActive: $isPressed) {
                            EmptyView()
                        }
                            .navigationBarBackButtonHidden(true) // Hide the back button
                            .navigationBarItems(leading: EmptyView())
                    )

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
                                .foregroundColor(.johnstblack)
                                .padding(.vertical, 9)
                                .padding(.horizontal, 9)
                                .cornerRadius(10)
                                .padding(.leading)
                                .padding(.top, 10)
                                .onTapGesture {
                                    for index in items {
                                        context.delete(index)
                                    }
                                }
                            
                            Spacer()
                        }
                        ForEach(items.suffix(4).reversed(), id: \.self) { item in
                            VStack (alignment: .leading) {
                                HStack {
                                    Text(item.origin)
                                        .font(Font.custom("London Tube", size: 18))
                                        .foregroundStyle(.white)
                                        .padding(.leading)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                        .padding([.leading, .trailing])
                                    Spacer()
                                    Text(item.destination)
                                        .font(Font.custom("London Tube", size: 18))
                                        .foregroundStyle(.white)
                                        .padding(.trailing)
                                }.padding(.top, 5)
                                    .padding(.bottom, 5)
                            }
                            .padding([.leading, .trailing, .top, .bottom])
                            .background(Color(.tfldeepblue))
                            .cornerRadius(10) // Adjust the corner radius as needed
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                origin = item.origin
                                destination = item.destination
                                isFast = item.isFastest
                                isShortest = item.isShortest
                                isFewestChange = item.isFewestChange
                                via = item.via ?? ""
                                avoid = item.avoid ?? ""
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.johnstblue))
                            )
                            .padding([.trailing, .leading])
                        }
                        
                    }
                    
                    Spacer()
                }
                .background(Color("grey10"))
                
                
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct PlanView_Previews: PreviewProvider {
        static var previews: some View {
            PlanView()
        }
    }
