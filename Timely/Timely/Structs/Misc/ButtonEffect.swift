//
//  ButtonEffect.swift
//  Timely
//
//  Created by Rishi Thiahulan on 01/01/2024.
//

import Foundation
import SwiftUI

struct buttonShrink: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(height: 5)
                .padding()
                .background(Color(.gray))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 0.8 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
