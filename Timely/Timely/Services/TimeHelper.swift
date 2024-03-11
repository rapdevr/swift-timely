//
//  TimeHelper.swift
//  Timely
//
//  Created by Rishi Thiahulan on 28/12/2023.
//

import Foundation

// function to get time and return appropriate keyword.
// used in conjunction with MenuView items.
func GetGreeting() -> String {
    // creates an instance of Date.
    let currentDate = Date()
    // gets creates an instance of calendar with properties like hour.
    let calendar = Calendar.current
    // get the component hour, from currentDate instance
    let hour = calendar.component(.hour, from: currentDate)

    if hour > 2 && hour < 12 {
        return "Morning"
    }
    else if hour > 12 && hour < 17 {
        return "Afternoon"
    }
    else {
        return "Evening"
    }
    
}

func GetTime() -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    let min = calendar.component(.minute, from: currentDate)
    var minute: String = ""
    
    if  min < 10 {
        minute = "0\(min)"
    }
    else {
        minute = "\(min)"
    }
    
    return "\(calendar.component(.hour, from: currentDate)):\(minute)"
}
