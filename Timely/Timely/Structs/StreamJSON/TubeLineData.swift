//
//  TubeLineStatus.swift
//  Timely
//
//  Created by Rishi Thiahulan on 01/01/2024.
//

import Foundation

// Structure to represent data for a tube line
struct TubeLineData: Decodable {
    let name: String? // Name of the tube line
    let lineStatuses: [LineStatus] // Array of line statuses
    let disruptions: [Disruption]? // Optional array of disruptions
}
