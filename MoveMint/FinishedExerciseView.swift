//
//  FinishedExerciseView.swift
//  MoveMint
//
//  Created by Ellie on 9/15/23.
//

import SwiftUI

struct FinishedExerciseView: View {
    
    var exerciseLog = ExerciseLog.shared

    @State private var showGroup11ContainerView = false
    @EnvironmentObject var selectedTabIndex: SelectedTabIndex
    @EnvironmentObject var dateManager: DateManager
    @State private var isDoneActionExecuted = false

    var exerciseName: String
    var date: Date

    var body: some View {
        VStack {
            Text("You Did It!")
                .font(Font.custom("Spartan", size: 64)
                .weight(.bold))
                .foregroundColor(.black)
        
            AvocadoGif("star")
                .frame(width: 200, height: 200)
                .padding(50)
                .padding(.top, 50)
        
            Button(action: {
                guard !isDoneActionExecuted else { return }
                isDoneActionExecuted = true
                
                exerciseLog.addExercise(exerciseName, on: date)
                dateManager.selectedDate = date
                selectedTabIndex.index = 1
                print("Button pressed: Adding exercise: \(exerciseName) for date: \(date)")
                
                self.showGroup11ContainerView = true // Trigger the transition
            }) {
                Text("Done")
                    .font(Font.custom("Spartan", size: 24)
                    .weight(.heavy))
                    .kerning(0.72)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 33)
                    .frame(width: 360, height: 79, alignment: .center)
                    .background(Color(red: 0.22, green: 0.77, blue: 0.38))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
            }
            
            NavigationLink(
                destination: Group11ContainerView(exerciseLog: exerciseLog),
                isActive: $showGroup11ContainerView
            ) {
                EmptyView()
            }

            .hidden()
        }
        //.navigationBarHidden(true)
    }
}

struct FinishedExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedExerciseView(exerciseName: "The Actual Exercise Name", date: Date())
            .environmentObject(DateManager())  // Ensure you provide the environment object here for previews as well.
    }
}



