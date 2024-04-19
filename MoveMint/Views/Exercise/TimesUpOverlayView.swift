//
//  TimesUpOverlayView.swift
//  MoveMint
//
//  Created by Ellie on 9/21/23.
//

import SwiftUI

struct TimesUpOverlayView: View {
    var exerciseName: String
    var onConfirm: () -> Void
    var onCancel: () -> Void
    var onSkip: () -> Void
    var onComplete: () -> Void

    @Binding var navigateToFinishedExerciseView: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear.onTapGesture(perform: onCancel)
                
                VStack(spacing: 15) {
                    Text("Time is up! Did you finish?")
                        .font(Font.custom("Spartan", size: 24).weight(.bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    Button(action: {
                        self.navigateToFinishedExerciseView.toggle()
                    }) {
                        Text("Mark Complete")
                            .styledPrimaryButton()
                    }
                    .padding(.bottom, 5)
                    
                    Button(action: onCancel) {
                        Text("Restart")
                            .styledSecondaryButton()
                    }
                    .padding(.bottom, 5)
                    
                    Button(action: onSkip) {
                        Text("Skip Exercise")
                            .styledSecondaryButton()
                    }
                    .padding(.bottom, 5)
                }
                .padding()
                .frame(width: 335, height: 385)  // Increased the height a bit
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 4)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .edgesIgnoringSafeArea(.all)
            //.navigationBarHidden(true)
            .overlay(
                NavigationLink(
                    destination: FinishedExerciseView(selectedTab: .constant(0), dismissExercisePage: .constant(false), exerciseName: exerciseName, date: Date()),
                    isActive: $navigateToFinishedExerciseView
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}




extension Text {
    func styledPrimaryButton() -> some View {
        self
            .font(Font.custom("Spartan", size: 24).weight(.heavy))
            .kerning(0.72)
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 33)
            .frame(width: 276, height: 65, alignment: .center)
            .background(Color(red: 0.22, green: 0.77, blue: 0.38))
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
    }
    
    func styledSecondaryButton() -> some View {
        self
            .font(Font.custom("Spartan", size: 24).weight(.heavy))
            .kerning(0.72)
            .foregroundColor(Color(red: 0.22, green: 0.77, blue: 0.38))
            .padding(.horizontal, 30)
            .padding(.vertical, 33)
            .frame(width: 276, height: 65, alignment: .center)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .inset(by: 1)
                    .stroke(Color(red: 0.22, green: 0.77, blue: 0.38), lineWidth: 2)
            )
    }
}
