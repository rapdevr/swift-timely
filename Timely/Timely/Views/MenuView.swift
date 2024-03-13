import SwiftUI
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
}
