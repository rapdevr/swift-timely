import SwiftUI
import UIKit


struct MenuView: View {
    
    @State private var origin: String = ""
    @State private var destination: String = ""
    @State var LinesArray: [TubeLine] = []
    @State var time: String?
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    var dataService: DataService = DataService()
        
    func RefreshList() {
        LinesArray.removeAll()
        dataService.updateService()
        LinesArray = dataService.tubeLinesArray
        time = "Refreshed at: " + getTime()
    }
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    
                    // HStack for the Title and subtitle
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Good \(getGreeting())!")
                                .font(.largeTitle)
                                .foregroundColor(colorScheme == .light ? Color(red: 0.011764705882352941, green: 0.027450980392156862, blue: 0.10980392156862745) : Color.white)
                                .bold()
                                .padding(.top, -13.0)
                            Text("Live Tube Status:")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .light ? Color(red: 0.0, green: 0.098, blue: 0.655) : .white)
                            
                        }
                        .padding(.top, 15.0)
                        
                        Spacer()
                        
                    }
                    .padding(.leading, 15.0)
                    .padding(/*@START_MENU_TOKEN@*/.top, 5.0)
                    HStack {
                        Button(action: {
                            RefreshList()
                        }, label: {
                            Text("Refresh")
                        })
                        .foregroundColor(.blue)
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text(time ?? "Not updated")
                            .padding(.trailing)
                        
                        
                    }
                    .padding(.top, 4)
                    .padding(.bottom, -6.0)
                    
                    
                    List (LinesArray) {line in
                        NavigationLink(destination: DetailView(tubeLine: line)){
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
                                                .foregroundStyle(.orange)
                                            
                                        }
                                        else if line.severityStatusDescription == "Part Closure"{
                                            Text(line.severityStatusDescription)
                                                .foregroundStyle(Color("crimson"))
                                        }
                                        else {
                                            Text(line.severityStatusDescription)
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    
                }
                .background(colorScheme == .dark ? Color.black : Color(red: 0.949, green: 0.949, blue: 0.971))
                .contentShape(Rectangle())
                .padding(.top, -8.0)
                .onAppear {
                    LinesArray.removeAll()  // Remove all elements before refreshing the list
                    RefreshList()
                    
                }
                
            }
            .background(Color(red: 0.949, green: 0.949, blue: 0.971))
        
            .tabItem {
                Label("Status", systemImage: "clock.fill")
            }
            
            PlanView().tabItem {
                Label("Plan", systemImage: "train.side.front.car")
            }
            
        }
    }
}



#Preview {
    MenuView()
}
