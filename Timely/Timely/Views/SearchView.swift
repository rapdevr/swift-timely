//
//  SearchView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 28/02/2024.
//

import SwiftUI


func ShortName(_ name:String) -> String {
    switch name {
    case "Bakerloo" :
        return "BAK"
    case "Central" :
        return "CEN"
    case "Circle" :
        return "CIR"
    case "District" :
        return "DST"
    case "Hammersmith & City" :
        return "H&C"
    case "Jubilee":
        return "JUB"
    case "Metropolitan" :
        return "MET"
    case "Northern" :
        return "NOR"
    case "Piccadilly" :
        return "PIC"
    case "Victoria" :
        return "VIC"
    case "Waterloo & City" :
        return "W&C"
    case "Elizabeth" :
        return "ELZ"
    default:
        return "ERR"
    }
    
}

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
                        }
                        
                        Spacer()
                        
                    }
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 55))], spacing: 2) {
                        ForEach(stationArray.indices, id: \.self) { index in
                            let stationInfo = stationArray[index]
                            if let stationInfo = stationInfo as? [Any],
                               let name = stationInfo[0] as? String,
                               let lines = stationInfo[1] as? [String] {
                                if name == stationName {
                                    ForEach(lines, id: \.self) { line in
                                        Text(ShortName(line))
                                            .frame(width: 40)
                                            .foregroundColor(.white)
                                            .padding(.vertical, 9)
                                            .padding(.horizontal, 7)
                                            .background(Color(GetColour(name: line)))
                                            .cornerRadius(10)
                                            .font(Font.custom("London Tube", size: 18))
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.leading)

                    
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
