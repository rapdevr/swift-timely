//
//  ColourHelper.swift
//  Timely
//
//  Created by Rishi Thiahulan on 15/01/2024.
//

import UIKit

// variables to store individual colours
let Bakerloo = UIColor(red: 0.61, green: 0.37, blue: 0.21, alpha: 1.00)
let Central = UIColor(red: 0.81, green: 0.23, blue: 0.17, alpha: 1.00)
let Circle = UIColor(red: 0.97, green: 0.81, blue: 0.27, alpha: 1.00)
let District = UIColor(red: 0.20, green: 0.47, blue: 0.24, alpha: 1.00)
let ElizabethLine = UIColor(red: 0.44, green: 0.25, blue: 0.71, alpha: 1.00)
let HC = UIColor(red: 0.88, green: 0.62, blue: 0.68, alpha: 1.00)
let Jubilee = UIColor(red: 0.49, green: 0.53, blue: 0.55, alpha: 1.00)
let Metropolitan = UIColor(red: 0.49, green: 0.12, blue: 0.32, alpha: 1.00)
let Northern = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0)
let Piccadilly = UIColor(red: 0.01, green: 0.06, blue: 0.60, alpha: 1.00)
let Victoria = UIColor(red: 0.28, green: 0.62, blue: 0.85, alpha: 1.00)
let WC = UIColor(red: 0.52, green: 0.80, blue: 0.70, alpha: 1.00)


// function that takes an input string, and returns an output of type UIColor
func GetColour(name: String) -> UIColor {
    if name == "Bakerloo"
    {
        return Bakerloo
    }
    
    if name == "Central"
    {
        return Central
    }
    
    if name == "Circle"
    {
        return Circle
    }
    
    if name == "District"
    {
        return District
    }
    if name == "Elizabeth line"
    {
        return ElizabethLine
    }
    
    if name == "Hammersmith & City"
    {
        return HC
    }
    
    if name == "Jubilee"
    {
        return Jubilee
    }
    
    if name == "Metropolitan"
    {
        return Metropolitan
    }
    
    if name == "Northern"
    {
        return Northern
    }
    
    if name == "Piccadilly"
    {
        return Piccadilly
    }
    
    if name == "Victoria"
    {
        return Victoria
    }
    
    if name == "Waterloo & City"
    {
        return WC
    }
    
    return UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    
}


