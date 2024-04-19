//
//  StyledButton.swift
//  MoveMint
//
//  Created by Ellie on 10/17/23.
//

import SwiftUI

struct StyledButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button(action: action) {
                Text(text)
                    .font(Font.custom("Spartan", size: 24).weight(.heavy))
                    .kerning(0.72)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 33)
            .frame(width: 370, height: 79, alignment: .center)
            .background(Color(red: 0.22, green: 0.77, blue: 0.38))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
            .onTapGesture(perform: action)
        }
    }
}

