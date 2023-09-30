//
//  Group11ContainerView.swift
//  MoveMint
//
//  Created by Ellie on 9/17/23.
//
import SwiftUI

struct Group11ContainerView: View {
    @ObservedObject var exerciseLog: ExerciseLog
    @EnvironmentObject var dateManager: DateManager
    @State private var navigateToSettings: Bool = false
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            ScrollableCalendarView(exerciseLog: exerciseLog)
                .padding(.top, 100)
            
            ScrollView {
                let exercises = exerciseLog.exercises(on: normalizedDate(from: dateManager.selectedDate))
                if let exercises = exercises, !exercises.isEmpty {
                    ForEach(exercises, id: \.self) { exercise in
                        VStack {
                            Text(exercise)
                                .font(.footnote)
                                .foregroundColor(.customGreen)
                                .padding(.horizontal, 10)
                        }
                        .frame(width: 370, height: 80)
                        .background(Color.white)
                        .cornerRadius(21)
                        .overlay(
                            RoundedRectangle(cornerRadius: 21)
                                .stroke(Color.customGreen, lineWidth: 1)
                        )
                        .padding(.bottom, 10) // add some spacing between the rectangles
                    }
                } else {
                    // No exercises for this date, so render an empty view
                    EmptyView()
                }
            }
            .navigationBarTitle("Stats", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                navigateToSettings = true
            }) {
                Image("gear") // Ensure this image is correctly named and exists
            })
            
            NavigationLink(destination: AnimatedPicker().navigationBarBackButtonHidden(true)) {
                Text("Start Another Exercise")
                    .font(Font.custom("Spartan", size: 24).weight(.heavy))
                    .kerning(0.72)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 33)
                    .frame(width: 360, height: 79, alignment: .center)
                    .background(Color(red: 0.22, green: 0.77, blue: 0.38))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
            }
            .padding(.bottom, 100) // add some spacing above the button
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        




        

        //.navigationBarHidden(true)
    }
}





