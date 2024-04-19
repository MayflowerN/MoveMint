//
//  FinishedExerciseView.swift
//  MoveMint
//
//  Created by Ellie on 9/15/23.
//

import SwiftUI

struct FinishedExerciseView: View {
    
    var exerciseLog = ExerciseLog.shared
    
    //@State private var showGroup11ContainerView = false
    //@EnvironmentObject var selectedTabIndex: SelectedTabIndex
    //@State var selection: Int = 0
    @EnvironmentObject var dateManager: DateManager
    //@State private var isDoneActionExecuted = false
    //@State private var navigateToGroup11 = false
    @Binding var selectedTab: Int
    @State private var navigateToGroup11 = false
    @Binding var dismissExercisePage: Bool
    @Environment(\.dismiss) private var dismiss
    
    //@Binding var path: NavigationPath
    var exerciseName: String
    var date: Date
    
    //var completion: () -> ()
    
    var body: some View {
        
        VStack {
            Text("You Did It!")
                .font(Font.custom("Spartan", size: 64)
                    .weight(.bold))
                .foregroundColor(.black)
                .padding(.top, 50)
            
            AvocadoGif("star")
                .frame(width: 200, height: 200)
                .padding(50)
                .padding(.top, 100)
            
            Spacer()
            
            //NavigationLink(destination: Group11ContainerView(exerciseLog: exerciseLog, completion: completion), isActive: $navigateToGroup11) {
//                EmptyView()
//            }
            Button(action: {
               // path.append("Group11ContainerView")
//                guard !isDoneActionExecuted else { return }
//                isDoneActionExecuted = true
                
               exerciseLog.addExercise(exerciseName, on: date)
                dateManager.selectedDate = date
                dismissExercisePage = true
                
                //selectedTabIndex.index = 1
                debugPrint("Button pressed: Adding exercise: \(exerciseName) for date: \(date)")
                
                
                
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
//            NavigationLink(destination: Group11ContainerView(exerciseLog: exerciseLog, completion: {
//                            dismiss()
//                        }), isActive: $navigateToGroup11) {
//                            EmptyView()

}
            .padding(.bottom, 50)
            //            NavigationLink(destination: Group11ContainerView(exerciseLog: exerciseLog, completion: completion)) {
            //                                EmptyView()
            
            
//        }
        .navigationBarHidden(true)
    }
}
    

struct FinishedExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedExerciseView(selectedTab: .constant(0), dismissExercisePage: .constant(false), exerciseName: "The Actual Exercise Name", date: Date())
            .environmentObject(DateManager())  // Ensure you provide the environment object here for previews as well.
    }
}



