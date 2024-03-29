//
//  DetailView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 15/01/2024.
//
/*
import SwiftUI

struct DetailView: View {
    let tubeLine: TubeLine
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        
        let colour = GetColour(name: tubeLine.name)
        
        VStack {
            VStack {
                Image(tubeLine.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                
                
                Text(tubeLine.name)
                    .font(Font.custom("London Tube", size: 32))
                    .foregroundColor(Color(colour))
                    .bold()
                    .font(.title)
                    .padding(.horizontal, 4.0)
                    .background(
                            Rectangle()
                                .cornerRadius(10)
                                .overlay(
                                    Rectangle()
                                        .cornerRadius(10)
                                        
                                )
                        )
                    .foregroundColor(colorScheme == .dark ? Color.black : .white)
                    .padding(.vertical, 2.0)
                    }
            
            if tubeLine.reason != nil {
                VStack{
                    
                    if tubeLine.severityStatusDescription == "Good Service" {
                        Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                            .foregroundStyle(.green)
                            .padding(.bottom)
                    }
                    else if tubeLine.severityStatusDescription == "Minor Delays" {
                        Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                            .foregroundStyle(.orange)
                            .padding(.bottom)
                        
                    }
                    else if tubeLine.severityStatusDescription == "Part Closure"{
                          Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                              .foregroundStyle(Color("crimson"))
                              .padding(.bottom)
                    }
                    else {
                        Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                            .foregroundStyle(.red)
                            .padding(.bottom)
                    }
                    
                    Text(tubeLine.reason ?? "")
                        .font(Font.custom("London Tube", size: 18))
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(Color(red: 0.002, green: 0.096, blue: 0.658))
                            .cornerRadius(10))
                        .foregroundColor(.white)
                        
                    Spacer()
                }
                .background(Rectangle()
                    .foregroundColor(colorScheme == .dark ? Color.black : .white)
                        .cornerRadius(10))
                .padding()
            }
            if tubeLine.reason == nil {
                Spacer()
                if tubeLine.severityStatusDescription == "Good Service" {
                    Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                        .foregroundStyle(.green)
                }
                else if tubeLine.severityStatusDescription == "Minor Delays" {
                    Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                        .foregroundStyle(.yellow)
                    
                }
                else if tubeLine.severityStatusDescription == "Part Closure"{
                      Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                          .foregroundStyle(Color("crimson"))
                }
                else {
                    Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                        .foregroundStyle(.red)
                    
                }
                
                Spacer()
            }
              
            
            Spacer()
            
        }
        .foregroundColor(.grey10)
        
    }
}
*/

import SwiftUI

// View to display details of a tube line
struct DetailView: View {
    let tubeLine: TubeLine // TubeLine object to display details
    @Environment(\.colorScheme) var colorScheme: ColorScheme // Environment variable to access color scheme
    
    // Body view
    var body: some View {
        
        let colour = GetColour(name: tubeLine.name) // Get color based on tube line name
        
        VStack {
            VStack {
                // Tube line image
                Image(tubeLine.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                
                // Tube line name
                Text(tubeLine.name)
                    .font(Font.custom("London Tube", size: 32))
                    .foregroundColor(Color(colour))
                    .bold()
                    .font(.title)
                    .padding(.horizontal, 4.0)
                    .background(
                            Rectangle()
                                .cornerRadius(10)
                                .overlay(
                                    Rectangle()
                                        .cornerRadius(10)
                                        
                                )
                        )
                    .foregroundColor(colorScheme == .dark ? Color.black : .white)
                    .padding(.vertical, 2.0)
            }
            
            // Display reason if available
            if tubeLine.reason != nil {
                VStack{
                    
                    // Display severity status with appropriate color
                    if tubeLine.severityStatusDescription == "Good Service" {
                        Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                            .foregroundStyle(.green)
                            .padding(.bottom)
                    }
                    else if tubeLine.severityStatusDescription == "Minor Delays" {
                        Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                            .foregroundStyle(.orange)
                            .padding(.bottom)
                    }
                    else if tubeLine.severityStatusDescription == "Part Closure" {
                        Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                            .foregroundStyle(Color("crimson"))
                            .padding(.bottom)
                    }
                    else {
                        Text(tubeLine.severityStatusDescription)
                            .font(Font.custom("London Tube", size: 18))
                            .foregroundStyle(.red)
                            .padding(.bottom)
                    }
                    
                    // Display reason
                    Text(tubeLine.reason ?? "")
                        .font(Font.custom("London Tube", size: 18))
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(Color(red: 0.002, green: 0.096, blue: 0.658))
                            .cornerRadius(10))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .background(Rectangle()
                    .foregroundColor(colorScheme == .dark ? Color.black : .white)
                    .cornerRadius(10))
                .padding()
            }
            
            // Display severity status if no reason available
            if tubeLine.reason == nil {
                Spacer()
                if tubeLine.severityStatusDescription == "Good Service" {
                    Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                        .foregroundStyle(.green)
                }
                else if tubeLine.severityStatusDescription == "Minor Delays" {
                    Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                        .foregroundStyle(.yellow)
                }
                else if tubeLine.severityStatusDescription == "Part Closure" {
                    Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                        .foregroundStyle(Color("crimson"))
                }
                else {
                    Text(tubeLine.severityStatusDescription)
                        .font(Font.custom("London Tube", size: 18))
                        .foregroundStyle(.red)
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .foregroundColor(.grey10)
    }
}

