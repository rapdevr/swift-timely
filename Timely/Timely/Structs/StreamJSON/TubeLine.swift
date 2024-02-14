//
//  TubeLine.swift
//  Timely
//
//  Created by Rishi Thiahulan on 01/01/2024.
//

import Foundation

struct TubeLine: Identifiable {
    let id:UUID = UUID()
    let name: String
    let severityValue: Int
    let severityStatusDescription: String
    let disruptionDescription: String
    let reason: String?
    
    init(name: String, severityValue: Int, severityStatusDescription: String, disruptionDescription: String, reason: String?) {
        self.name = name
        self.severityValue = severityValue
        self.severityStatusDescription = severityStatusDescription
        self.disruptionDescription = disruptionDescription
        self.reason = reason
    }
}
