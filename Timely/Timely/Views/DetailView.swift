//
//  DetailView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 15/01/2024.
//

import SwiftUI

struct DetailView: View {
    let tubeLine: TubeLine

    var body: some View {
        
        let colour = getColour(name: tubeLine.name)
        
        VStack {
            VStack {
                Image(tubeLine.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                
                
                Text(tubeLine.name)
                    .foregroundColor(Color(colour))
                    .bold()
                    .font(.title)
                    .padding(.horizontal, 4.0)
                    .background(
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .overlay(
                                    Rectangle()
                                        .cornerRadius(10)
                                        
                                )
                        )
                    .foregroundColor(.white)
                    .padding(/*@START_MENU_TOKEN@*/.vertical, 2.0/*@END_MENU_TOKEN@*/)
                    }
            
            if tubeLine.reason != nil {
                VStack{
                    
                    if tubeLine.severityStatusDescription == "Good Service" {
                        Text(tubeLine.severityStatusDescription)
                            .foregroundStyle(.green)
                    }
                    else if tubeLine.severityStatusDescription == "Minor Delays" {
                        Text(tubeLine.severityStatusDescription)
                            .foregroundStyle(.yellow)
                        
                    }
                    else {
                        Text(tubeLine.severityStatusDescription)
                            .foregroundStyle(.red)
                    }
                    
                    Spacer()
                    
                    Text(tubeLine.reason ?? "")
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(Color(red: 0.002, green: 0.096, blue: 0.658))
                            .cornerRadius(10))
                        .foregroundColor(.white)
                        
                    Spacer()
                }
                .background(Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(10))
                .padding()
            }
            if tubeLine.reason == nil {
                Spacer()
                if tubeLine.severityStatusDescription == "Good Service" {
                    Text(tubeLine.severityStatusDescription)
                        .foregroundStyle(.green)
                }
                else if tubeLine.severityStatusDescription == "Minor Delays" {
                    Text(tubeLine.severityStatusDescription)
                        .foregroundStyle(.yellow)
                    
                }
                else {
                    Text(tubeLine.severityStatusDescription)
                        .foregroundStyle(.red)
                    
                }
                
                Spacer()
            }
              
            
            Spacer()
            
        }
        .navigationBarTitle("Tube Details", displayMode: .inline)
    }
}
