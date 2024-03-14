//
//  JourneyItem.swift
//  Timely
//
//  Created by Rishi Thiahulan on 11/03/2024.
//

import Foundation
import SwiftData

@Model
// model to represent a journey item
class JourneyItem: Identifiable {
    var id: String
    var origin: String
    var destination: String
    var isFastest: Bool
    var isShortest: Bool
    var isFewestChange: Bool
    var via: String? // optional station to go via
    var avoid: String? // optional station to avoid
    
    // initialiser to create a journey item instance
    init(_ origin: String, _ destination: String, _ isFastest: Bool, _ isShortest: Bool, _ isFewestChange: Bool, _ via: String?, _ avoid: String?) {
        
        // generate a unique ID for the journey item.
        self.id = UUID().uuidString
        
        self.origin = origin
        self.destination = destination
        self.isFastest = isFastest
        self.isShortest = isShortest
        self.isFewestChange = isFewestChange
        self.via = via // optional via
        self.avoid = avoid // optional avoid
    }
}
