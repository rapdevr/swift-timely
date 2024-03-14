//
//  LineStatus.swift
//  Timely
//
//  Created by Rishi Thiahulan on 01/01/2024.
//

import Foundation

// Structure to represent the status of a line
struct LineStatus: Decodable {
    let statusSeverity: Int? // Severity of the line status
    let statusSeverityDescription: String? // Description of the line status severity
    let reason: String? // Reason for the line status
}
