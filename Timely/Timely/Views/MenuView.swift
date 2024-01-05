import SwiftUI
import UIKit

@main

struct Timely: App {
    var body: some Scene {
            WindowGroup {
                MenuView()
                    .onAppear {
                        MenuView.RefreshList
                    }
            }
}

struct MenuView: View {
    
    @State private var origin: String = ""
    @State private var destination: String = ""
    
    @State var LinesArray: [TubeLine] = []
    
    var dataService: DataService = DataService()
    
    func RefreshList() {
        LinesArray.removeAll()
        dataService.updateService()
        LinesArray = dataService.tubeLinesArray
    }
    
    var body: some View {
        
        VStack {
            
            // HStack for the Title and subtitle
            HStack {
                VStack (alignment: .leading) {
                    Text("Good \(getTime())!")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745))
                        .bold()
                        .padding(.top, -13.0)
                    Text("Live Tube Status:")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.0, green: 0.098, blue: 0.655)/*@END_MENU_TOKEN@*/)
                        
                }
                .padding(.top, 15.0)
                
                Spacer()
                    
            }
            .padding(.leading, 15.0)
            .padding(/*@START_MENU_TOKEN@*/.top, 5.0)
            
                List (LinesArray) {line in
                    HStack {
                        Image(line.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                            .cornerRadius(10)
                        Text(line.name)
                            .bold()
                        
                        VStack {
                            
                            HStack {
                                Spacer()
                                if line.severityStatusDescription == "Good Service" {
                                    Text(line.severityStatusDescription)
                                        .foregroundStyle(.green)
                                }
                                else if line.severityStatusDescription == "Minor Delays" {
                                    Text(line.severityStatusDescription)
                                        .foregroundStyle(.yellow)
                                    
                                }
                                else {
                                    Text(line.severityStatusDescription)
                                        .foregroundStyle(.red)
                                }
                            }
                            
                            Text(line.reason ?? "")
                        }
                    }
                    
                }
                .navigationTitle("Current Status")
                .contentShape(Rectangle())
                .padding(.top, -8.0)
                .background(Color.white)
                .onAppear {
                    LinesArray.removeAll()  // Remove all elements before refreshing the list
                    RefreshList()
                    
                }
            
            Button(action: {
                RefreshList()
            }, label: {
                Text("Refresh")
            })
            .padding(.bottom, 8.0)
            .buttonStyle(buttonShrink())
            
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
            
    }
            
    }



#Preview {
    MenuView()
}
