//
//  TubeLineStatus.swift
//  Timely
//
//  Created by Rishi Thiahulan on 01/01/2024.
//

import Foundation

struct TubeLineData: Decodable {
    let name: String?
    let lineStatuses: [LineStatus]
    let disruptions: [Disruption]?
}
