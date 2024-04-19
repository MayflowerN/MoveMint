//
//  CustomNavigationBar.swift
//  MoveMint
//
//  Created by Ellie on 9/30/23.
//
import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let trailingAction: () -> Void

    var body: some View {
        HStack {
            Spacer()  // Push the title and the button to opposite ends
            Text(title)
                .font(.headline)
            Spacer()
            Button(action: trailingAction) {
                Image("gear")  // Assuming you have a gear image in your assets
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)  // Add space for status bar
        
    }
}
