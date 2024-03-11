//
//  ToggleButton.swift
//  Timely
//
//  Created by Rishi Thiahulan on 05/03/2024.
//

import Foundation
import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                configuration.label
                        
                    .background(configuration.isOn ? Color.gray : Color.white) // Change background color here
                    .cornerRadius(8)
            }
        }
    }
}
