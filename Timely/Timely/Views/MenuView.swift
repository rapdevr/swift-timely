/*import SwiftUI
import UIKit
import SwiftData

struct MenuView: View {
    
    @State var LinesArray: [TubeLine] = []
    @State var time: String?
    var dataService: DataService = DataService()
    
    init() {
        GraphConstructor().BuildGraph()
        RefreshList()
        }
        
    func RefreshList() {
        LinesArray.removeAll()
        dataService.UpdateService()
        LinesArray = dataService.tubeLinesArray
        time = "Refreshed at: " + GetTime()
        
    }
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    
                    // HStack for the Title and subtitle
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Good \(GetGreeting())!")
                                .font(Font.custom("London Tube", size: 32, relativeTo: .largeTitle))
                                .foregroundStyle(.white)
                                .padding(.top, -13.0)
                            Text("Latest updates on the tube:")
                                .font(Font.custom("London Tube", size: 24, relativeTo: .title))
                                .foregroundColor(Color(.white))
                            
                        }
                        .padding(.top, 15.0)
                        .padding(.leading)
                        Spacer()
                        
                    }
                    .padding(.bottom)
                    .background(Color("johnstblue"))
                    HStack {
                        Button(action: {
                            RefreshList()
                        }, label: {
                            Text("Refresh")
                                .font(Font.custom("London Tube", size: 18))
                                .foregroundColor(.johnstblue)
                                .padding([.leading, .trailing])
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(.johnstblue), lineWidth: 1)
                                )
                        })
                        .foregroundColor(.blue)
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text(time ?? "Not updated")
                            .padding(.trailing)
                            .font(Font.custom("London Tube", size: 18))
                        
                        
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
                                    .font(Font.custom("London Tube", size: 18))
                                
                                VStack {
                                    
                                    HStack {
                                        Spacer()
                                        if line.severityStatusDescription == "Good Service" {
                                            Text(line.severityStatusDescription)
                                                .font(Font.custom("London Tube", size: 18))
                                                .foregroundStyle(.green)
                                        }
                                        else if line.severityStatusDescription == "Minor Delays" {
                                            Text(line.severityStatusDescription)
                                                .font(Font.custom("London Tube", size: 18))
                                                .foregroundStyle(.orange)
                                            
                                        }
                                        else if line.severityStatusDescription == "Part Closure"{
                                            Text(line.severityStatusDescription)
                                                .font(Font.custom("London Tube", size: 18))
                                                .foregroundStyle(Color("crimson"))
                                        }
                                        else {
                                            Text(line.severityStatusDescription)
                                                .font(Font.custom("London Tube", size: 18))
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    
                }
                .background(Color(.grey10))
                .padding(.top, -8.0)
                
            }
            .onAppear {
                RefreshList()
            }
            
            .tabViewStyle(PageTabViewStyle())
        
            .tabItem {
                Text("Status")
                    .font(Font.custom("London Tube", size: 12))
                Image(systemName: "clock.fill")
            }
            
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass.circle.fill")
                    .font(Font.custom("London Tube", size: 12))
            }
            
            PlanView().tabItem {
                Text("Plan")
                    .font(Font.custom("London Tube", size: 12))
                Image(systemName: "train.side.front.car")
            }
            
        }
    }
}



#Preview {
    MenuView()
}*/

import SwiftUI
import UIKit
import SwiftData
import Network

// View for the main menu
struct MenuView: View {
    
    // State variables
    @State var LinesArray: [TubeLine] = [] // Array to hold tube lines
    @State var time: String? // Optional string to hold the refresh time
    var dataService: DataService = DataService() // DataService object
    
    // Initializer
    init() {
        // Build graph and refresh list on initialization
        GraphConstructor().BuildGraph()
        RefreshList()
    }
    
    // Function to refresh the list
    func RefreshList() {
        // Clear existing data and update service
        LinesArray.removeAll()
        dataService.UpdateService()
        LinesArray = dataService.tubeLinesArray
        time = "Refreshed at: " + GetTime() // Update time
    }
    
    func isDeviceOffline() -> Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        
        var isOffline = false
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // Device is online
                isOffline = false
            } else {
                // Device is offline
                isOffline = true
            }
        }
        
        monitor.start(queue: queue)
        
        // Wait for a moment for the monitor to update the status
        // You may want to handle asynchronous operations differently in your app
        Thread.sleep(forTimeInterval: 0.5)
        
        return isOffline
    }
    
    // Body view
    var body: some View {
        TabView {
            // Status view
            NavigationView {
                VStack {
                    // Title and subtitle
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Good \(GetGreeting())!")
                                .font(Font.custom("London Tube", size: 32, relativeTo: .largeTitle))
                                .foregroundStyle(.white)
                                .padding(.top, -13.0)
                            Text("Latest updates on the tube:")
                                .font(Font.custom("London Tube", size: 24, relativeTo: .title))
                                .foregroundColor(Color(.white))
                        }
                        .padding(.top, 15.0)
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.bottom)
                    .background(Color("johnstblue"))
                    
                    // Refresh button and time label
                    HStack {
                        Button(action: {
                            RefreshList()
                        }, label: {
                            Text("Refresh")
                                .font(Font.custom("London Tube", size: 18))
                                .foregroundColor(.johnstblue)
                                .padding([.leading, .trailing])
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(.johnstblue), lineWidth: 1)
                                )
                        })
                        .foregroundColor(.blue)
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text(time ?? "Not updated")
                            .padding(.trailing)
                            .font(Font.custom("London Tube", size: 18))
                    }
                    .padding(.top, 4)
                    .padding(.bottom, -6.0)
                    
                    // List of tube lines
                    if !isDeviceOffline() {
                        List (LinesArray) {line in
                            NavigationLink(destination: DetailView(tubeLine: line)){
                                HStack {
                                    Image(line.name)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 25)
                                        .cornerRadius(10)
                                    Text(line.name)
                                        .font(Font.custom("London Tube", size: 18))
                                    
                                    // Display severity status with appropriate color
                                    VStack {
                                        HStack {
                                            Spacer()
                                            if line.severityStatusDescription == "Good Service" {
                                                Text(line.severityStatusDescription)
                                                    .font(Font.custom("London Tube", size: 18))
                                                    .foregroundStyle(.green)
                                            }
                                            else if line.severityStatusDescription == "Minor Delays" {
                                                Text(line.severityStatusDescription)
                                                    .font(Font.custom("London Tube", size: 18))
                                                    .foregroundStyle(.orange)
                                            }
                                            else if line.severityStatusDescription == "Part Closure" {
                                                Text(line.severityStatusDescription)
                                                    .font(Font.custom("London Tube", size: 18))
                                                    .foregroundStyle(Color("crimson"))
                                            }
                                            else {
                                                Text(line.severityStatusDescription)
                                                    .font(Font.custom("London Tube", size: 18))
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    else {
                        Spacer()
                        Text("You're offline!")
                            .font(Font.custom("London Tube", size: 32))
                        Spacer()
                    }
                }
                .background(Color(.grey10))
                .padding(.top, -8.0)
            }
            .onAppear {
                RefreshList()
            }
            .tabViewStyle(PageTabViewStyle())
            .tabItem {
                Text("Status")
                    .font(Font.custom("London Tube", size: 12))
                Image(systemName: "clock.fill")
            }
            
            // Search view
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass.circle.fill")
                    .font(Font.custom("London Tube", size: 12))
            }
            
            // Plan view
            PlanView().tabItem {
                Text("Plan")
                    .font(Font.custom("London Tube", size: 12))
                Image(systemName: "train.side.front.car")
            }
        }
    }
}

// Preview
#Preview {
    MenuView()
}

