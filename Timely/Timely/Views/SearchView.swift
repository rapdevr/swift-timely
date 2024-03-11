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
    @State private var station: String = ""
    @State private var filteredStations: [String] = []
    
    var body: some View {
        VStack{
            HStack {
                Text("Search for a station")
                    .font(Font.custom("London Tube", size: 32, relativeTo: .largeTitle))
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.leading)  // Apply here for the heading
                    .foregroundColor(Color(.white))
                
                Spacer()
            }
            .padding(.bottom)
            .background(Color("johnstblue"))
            .padding(.bottom)
            VStack {
                HStack {
                    TextField("Enter Station", text: $station)
                        .padding([.top, .leading, .bottom])
                        .font(Font.custom("London Tube", size: 18))
                        .onTapGesture {
                            stationTap = true
                        }
                        .sheet(isPresented: $stationTap) {
                            TextField("Enter Station", text: $station)
                                .padding([.top, .leading, .bottom])
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
                                ).padding()
                                .onChange(of: station) { value in
                                    filteredStations = undergroundStations.filter {$0.lowercased().contains(value.lowercased()) }
                                    
                                }
                                .presentationDetents([.medium, .large])
                            
                            List (filteredStations, id:\.self) { stations in
                                Text(stations)
                                    .onTapGesture {
                                        station = stations
                                        stationTap = false
                                    }
                            }
                        }
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                    Image(systemName: "magnifyingglass")
                    }).padding(.trailing)
                }
                
            }.background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white, lineWidth: 2)
            ).padding([.leading, .trailing])
            Spacer()
        }.background(Color("grey10"))
        
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView()
        }
    }
