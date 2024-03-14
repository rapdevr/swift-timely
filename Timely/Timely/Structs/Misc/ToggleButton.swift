//
//  ToggleButton.swift
//  Timely
//
//  Created by Rishi Thiahulan on 05/03/2024.
//

import Foundation
import SwiftUI

// custom toggle style conforming to ToggleStyle protocol
struct CustomToggleStyle: ToggleStyle {
    
    // function to define toggle appearance
    func makeBody(configuration: Configuration) -> some View {
        // button to handle toggle action
        Button(action: {
            // toggle the station of the button
            configuration.isOn.toggle()
        }) {
            // horizontal formatting
            HStack {
                configuration.label
                    // setting background colour
                    .background(configuration.isOn ? Color.gray : Color.white) // Change background color here
                    .cornerRadius(8)
            }
        }
    }
}
