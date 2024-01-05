//
//  LineStatus.swift
//  Timely
//
//  Created by Rishi Thiahulan on 01/01/2024.
//

import Foundation

struct LineStatus: Decodable {
    let statusSeverity: Int?
    let statusSeverityDescription: String?
    let reason: String?
}
