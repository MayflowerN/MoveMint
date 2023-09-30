//
//  SkipOverlayView.swift
//  MoveMint
//
//  Created by Ellie on 9/15/23.
//
import SwiftUI

struct SkipOverlayView: View {
    var onConfirm: () -> Void
    var onCancel: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear.onTapGesture(perform: onCancel)
                
                VStack(spacing: 15) {
                    Text("Skip the exercise?")
                        .font(
                        Font.custom("Spartan", size: 24)
                        .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .padding(.bottom, 20)

                    Button(action: onConfirm) {
                        Text("Yes")
                            .font(
                            Font.custom("Spartan", size: 24)
                            .weight(.heavy)
                            )
                            .kerning(0.72)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 33)
                            .frame(width: 276, height: 61, alignment: .center)
                            .background(Color(red: 0.22, green: 0.77, blue: 0.38))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
                    }
                    
                    Button(action: onCancel) {
                        Text("Cancel")
                            .font(
                            Font.custom("Spartan", size: 24)
                            .weight(.heavy)
                            )
                            .kerning(0.72)
                            .foregroundColor(Color(red: 0.22, green: 0.77, blue: 0.38))

                            .padding(.horizontal, 30)
                            .padding(.vertical, 33)
                            .frame(width: 276, height: 61, alignment: .center)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                .inset(by: 1)
                                .stroke(Color(red: 0.22, green: 0.77, blue: 0.38), lineWidth: 2)
                            )
                    }
                }
                .padding()
                .frame(width: 328, height: 315)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 4)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        .edgesIgnoringSafeArea(.all)
        //.navigationBarHidden(true)
    }
}
