//
//  SearchView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 28/02/2024.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var stationTap:Bool = false
    @State private var stationName: String = ""
    @State private var filteredStations: [String] = []
    @State private var isTapped: Bool = false
    
    var body: some View {
        VStack{
            HStack {
                Text("Search for a station")
                    .font(Font.custom("London Tube", size: 32, relativeTo: .largeTitle))
                    .bold()  // Apply here for the heading
                    .foregroundColor(Color(.white))
            Spacer()
            }
            .padding()
            .background(Color("johnstblue"))
            .padding(.bottom)
            VStack {
                HStack {
                    TextField("Enter Station", text: $stationName)
                        .padding([.top, .leading, .bottom])
                        .font(Font.custom("London Tube", size: 18))
                        .onTapGesture {
                            stationTap = true
                        }
                        .sheet(isPresented: $stationTap) {
                            TextField("Enter Station", text: $stationName)
                                .padding([.top, .leading, .bottom])
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
                                ).padding()
                                .onChange(of: stationName) { value in
                                    filteredStations = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                    
                                }
                                .presentationDetents([.medium, .large])
                            
                            List (filteredStations, id:\.self) { stations in
                                Text(stations)
                                    .font(Font.custom("London Tube", size: 18))
                                    .onTapGesture {
                                        stationName = stations
                                        stationTap = false
                                    }
                            }
                        }
                    
                    Spacer()
                    
                    Button(action: {
                        isTapped.toggle()
                    }, label: {
                    Image(systemName: "magnifyingglass")
                    }).padding(.trailing)
                }
                
            }.background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
            ).padding([.leading, .trailing])
            Spacer()
            
            if isTapped {
                VStack {
                    HStack {
                        VStack{
                            Text(stationName)
                                .font(Font.custom("London Tube", size: 32))
                                .padding([.leading, .top])
                            
                            Text("Served By:")
                                .font(Font.custom("London Tube", size: 28))
                                .padding(.leading)
                        }
                        
                        Spacer()
                        
                    }
                    
                    ForEach(stationArray.indices, id: \.self) { index in
                        let stationInfo = stationArray[index]
                        if let stationInfo = stationInfo as? [Any],
                           let name = stationInfo[0] as? String,
                           let lines = stationInfo[1] as? [String] {
                            if name == stationName {
                                ForEach(lines, id: \.self) { line in
                                    HStack {
                                        Image(line)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 20)
                                            .cornerRadius(10)
                                            .padding((.leading))
                                        Text(line)
                                            .font(Font.custom("London Tube", size: 18))
                                    }.padding(.leading)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }


            
        }.background(Color("grey10"))
        
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView()
        }
    }
