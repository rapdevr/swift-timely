import Foundation
import Combine

class DataService: ObservableObject {
    var tubeLinesArray: [TubeLine] = []

    // Function to fetch JSON data from the given URL
    func fetchJSONData(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }

            completion(data)
        }.resume()
    }

    // Function to parse JSON and create an array of TubeLine objects
    func parseJSON(jsonData: Data) {
        // clear existing data before updating
        tubeLinesArray.removeAll()
        
        do {
            let jsonDecoder = JSONDecoder()
            let tubeLinesData = try jsonDecoder.decode([TubeLineData].self, from: jsonData)

            for lineData in tubeLinesData {
                if let name = lineData.name,
                   let lineStatus = lineData.lineStatuses.first,
                   let severityValue = lineStatus.statusSeverity,
                   let severityStatusDescription = lineStatus.statusSeverityDescription {

                    var disruptionDescription = ""
                    if let disruptions = lineData.disruptions,
                       let disruption = disruptions.first?.description {
                        disruptionDescription = disruption
                    }
                    print(name, lineStatus, severityValue, severityStatusDescription, disruptionDescription)
                    
                    let reason = lineStatus.reason
                    
                    let tubeLine = TubeLine(name: name,
                                            severityValue: severityValue,
                                            severityStatusDescription: severityStatusDescription,
                                            disruptionDescription: disruptionDescription, reason: reason)

                    tubeLinesArray.append(tubeLine)
                }
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }

    // Fetch JSON data from the URL and parse it
    func updateService() {
        let apiUrlString = "https://api.tfl.gov.uk/Line/Mode/tube,%20elizabeth-line/Status?detail=false"

        if let apiUrl = URL(string: apiUrlString) {
            fetchJSONData(from: apiUrl) { data in
                guard let jsonData = data else {
                    return
                }

                self.parseJSON(jsonData: jsonData)
            }
        }
    }
}

// For backward compatibility
let tubeLineViewModel = DataService()

// Call the update service and refresh contents on LinesArray
func updateService() {
    tubeLineViewModel.tubeLinesArray.removeAll()
    tubeLineViewModel.updateService()
}
