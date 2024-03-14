//
//  TubeLine.swift
//  Timely
//
//  Created by Rishi Thiahulan on 01/01/2024.
//

import Foundation

// struct to represent a tube line
struct TubeLine: Identifiable {
    let id:UUID = UUID() // unique identifier for tube line
    let name: String // name of the tube line
    let severityValue: Int // severity value of tube line
    let severityStatusDescription: String // description of the severity value
    let disruptionDescription: String // description of the disruption for that tube line
    let reason: String? // reason for the disruption
    
    // initialise function to create new TubeLine instance
    init(name: String, severityValue: Int, severityStatusDescription: String, disruptionDescription: String, reason: String?) {
        self.name = name
        self.severityValue = severityValue
        self.severityStatusDescription = severityStatusDescription
        self.disruptionDescription = disruptionDescription
        self.reason = reason
    }
}
