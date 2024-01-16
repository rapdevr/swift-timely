import SwiftUI
import UIKit


struct MenuView: View {
    
    @State private var origin: String = ""
    @State private var destination: String = ""
    @State var LinesArray: [TubeLine] = []
    @State var time: String?
    
    
    var dataService: DataService = DataService()
        
    func RefreshList() {
        LinesArray.removeAll()
        dataService.updateService()
        LinesArray = dataService.tubeLinesArray
        time = "Refreshed at: " + getTime()
    }
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    
                    // HStack for the Title and subtitle
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Good \(getGreeting())!")
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
                    HStack {
                        Button(action: {
                            RefreshList()
                        }, label: {
                            Text("Refresh")
                        })
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text(time ?? "Not updated")
                            .padding(.trailing)
                        
                        
                    }
                    .padding(.top, 4)
                    .padding(/*@START_MENU_TOKEN@*/.bottom, -6.0/*@END_MENU_TOKEN@*/)
                    
                    
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
                                                .foregroundStyle(.yellow)
                                            
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
                .contentShape(Rectangle())
                .padding(.top, -8.0)
                .onAppear {
                    LinesArray.removeAll()  // Remove all elements before refreshing the list
                    RefreshList()
                    
                }
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                
                .tabItem {
                    Label("Status", systemImage: "clock.fill")
                }
                
                PlanView().tabItem {
                    Label("Plan", systemImage: "train.side.front.car")
                }

            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
            
            
            
        }
            }
        }



#Preview {
    MenuView()
}
