//
//  ContentView.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//
//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//    @State private var refreshKey: UUID = UUID() 
//    
//    @State private var chosenDifficulty: Difficulty = .easy
//       @State private var chosenExerciseName: String = ""
//
//    var body: some View {
//        NavigationView {
//            switch viewRouter.currentPage {
//            case .onboarding_1:
//                Onboarding_1().id(viewRouter.refreshKey)
//            case .signupView:
//                SignUpView()
//            case .onboarding_2:
//                Onboarding_2()
//            case .onboarding_3:
//                Onboarding_3()
//            case .mainTabView:
//                MainTabView()
//                    .environmentObject(viewRouter)
//            case .mainSettingsView:
//                MainSettingsView().environmentObject(viewRouter)
//            case .animatedPicker:
//                AnimatedPicker(completion: { }).environmentObject(viewRouter)
//            case .group11ContainerView:
//                Group11ContainerView(exerciseLog: ExerciseLog.shared, completion: { }).environmentObject(viewRouter)
//            case .exercisePage(let difficulty, let exerciseName):  // Handle the case with associated values here
//                ExercisePage(difficulty: difficulty, exerciseName: $chosenExerciseName, completion: { _ in }).environmentObject(viewRouter)
//            }
//            
//        }
//        
//    }
//}
//
