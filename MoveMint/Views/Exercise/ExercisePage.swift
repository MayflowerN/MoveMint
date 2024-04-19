//
//  ExercisePage.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//

import SwiftUI

enum Difficulty: String, Identifiable, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var id: String {
        rawValue
    }
    
    var duration: Int {
        switch self {
        case .easy:
            return 30
        case .medium:
            return 60
        case .hard:
            return 90
        }
    }
}

struct ExercisePage: View {
    @State private var countdownValue: Int = 3
    @State private var phase: ExercisePhase = .initialCountdown
    @State private var exerciseTimer: Timer?
    @State private var isPaused = false
    @State private var showResetOverlay = false
    @State private var showSkipOverlay = false
    @State private var showAnimatedPicker = false
    @State private var showFinishedExerciseView = false
  @State private var shouldDismiss = false
    @State private var path = NavigationPath()
    //@EnvironmentObject var viewRouter: ViewRouter
    
@EnvironmentObject var exerciseLog: ExerciseLog
//    @EnvironmentObject var dateManager: DateManager
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    
    var completion: ((Bool) -> ())?
    
    @State private var showTimesUpOverlay = false
    
    
    let difficulty: Difficulty
    @Binding var exerciseName: String
    
    init(difficulty: Difficulty, exerciseName: Binding<String>, completion: @escaping (Bool) -> ()) {
        self.completion = completion
        self.difficulty = difficulty
        self._exerciseName = exerciseName
        debugPrint("Initializer difficulty is: \(difficulty.rawValue)")
    }
    
    enum ExercisePhase {
        case initialCountdown, exercise, finished
    }
    func markExerciseComplete() {
        // Here's a simple implementation - you need to define what it means
        // to "add the exercise to Group 11 tab icon".
        exerciseLog.addExercise(exerciseName, on: Date())
        showFinishedExerciseView = true
    }
    func resetAndRestartExercise() {
            resetExercise() // This resets the exercise
            beginExercise() // This restarts the exercise
            showTimesUpOverlay = false // Dismiss the TimesUpOverlayView
        }
    var body: some View {
        NavigationStack  {
        
                ZStack {
                    VStack(spacing: 20) {
                        
                        
                        Text(exerciseName)
                            .font(Font.custom("Urbanist", size: 35).weight(.black))
                            .kerning(0.84)
                            .foregroundColor(.black)
                        
                        if phase == .initialCountdown {
                            Text("\(countdownValue)")
                                .font(Font.custom("Urbanist", size: 28).weight(.semibold))
                                .kerning(0.84)
                                .foregroundColor(.black)
                        } else if phase == .finished {
                            Text("Time's Up!")
                                .font(Font.custom("Urbanist", size: 28).weight(.semibold))
                                .kerning(0.84)
                                .foregroundColor(.black)
                        }
                        
                        // Assuming AvocadoGif is another View component you have
                        Spacer()
                        AvocadoGif("avocado")
                            .frame(width: 200, height: 200)
                        
                        if phase == .exercise {
                            Text("\(countdownValue)")
                                .font(Font.custom("Urbanist", size: 28).weight(.semibold))
                                .kerning(0.84)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: FinishedExerciseView(selectedTab: .constant(0), dismissExercisePage: $shouldDismiss, exerciseName: exerciseName, date: Date())) {
                            
                            Image("greencheck")
                                .frame(width: 100, height: 100)
                            //                            exerciseLog.addExercise(exerciseName, on: Date())
                            //                                               dateManager.selectedDate = Date() // Update date in dateManager
                            //                                               showFinishedExerciseView = true
                            //                                               completion?(true)
                            //
                            //                            })
                            //                        {
                            
                            
                            
                            //                        NavigationLink(isActive: $showFinishedExerciseView) {
                            //                                            FinishedExerciseView(selectedTab: .constant(1), exerciseName: exerciseName, date: Date(), completion: {
                            //                                                dismiss()
                            //                                                                   })
                            //                        } label: {
                            //                            EmptyView()
                            
                            
                        }
                        .onChange(of: shouldDismiss) { _ in
                            dismiss()
                            
                            
                    }
                        .padding()
                                
                                
                                   HStack {
                                    Button(action: togglePause) {
                                        Image(isPaused ? "play" : "pause")
                                    }
                                    .padding()
                                    
                                    Button(action: {
                                        exerciseTimer?.invalidate()
                                        showResetOverlay = true
                                    }) {
                                        Image("reset")
                                    }
                                    .padding()
                                    
                                    Button(action: {
                                        exerciseTimer?.invalidate()
                                        showSkipOverlay = true
                                    }) {
                                        Image("skip")
                                    }
                                    .padding()
                                
                           
                        
                    }
                }
                    .navigationBarTitle("Exercise", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    //.environmentObject(viewRouter)// Hides the back button
                    

                if showSkipOverlay {
                    ZStack {
                        Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                        
                        // Assuming ResetOverlayView is another View component you have
                        SkipOverlayView(onConfirm: {
                            // Handle skip confirmation
                            self.dismiss()
                            self.completion?(false)
                            self.showSkipOverlay = false
                        }, onCancel: {
                            self.showSkipOverlay = false
                            if !isPaused { startInitialCountdown() }
                        })
                    }
                }
                
                if showResetOverlay {
                    ZStack {
                        Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                        
                        ResetOverlayView(onConfirm: {
                            self.resetExercise()
                            self.showResetOverlay = false
                        }, onCancel: {
                            self.showResetOverlay = false
                            if !isPaused { startInitialCountdown() }
                        })
                    }
                }
                
                if showAnimatedPicker {
                    // Assuming AnimatedPicker is another view you've created
                    AnimatedPicker(completion: { })
                    // Add any required actions or bindings you might need for AnimatedPicker
                }
                
                    if showTimesUpOverlay {
                               ZStack {
                                   Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                                   
                                   TimesUpOverlayView(
                                       exerciseName: exerciseName,
                                       onConfirm: { /* ... */ },
                                       onCancel: resetAndRestartExercise, // Pass the reset and restart function here
                                       onSkip: {
                                           // Handle the skip action
                                           self.showTimesUpOverlay = false
                                           self.dismiss()
                                       },
                                       onComplete: markExerciseComplete,
                                       navigateToFinishedExerciseView: $showFinishedExerciseView
                                   )
                               }
                           }
            }
        }
        
        
        .onAppear {
            // Combine all your onAppear logic here
            startInitialCountdown()
            debugPrint("Initializer difficulty is: \(difficulty.rawValue)")
            debugPrint("Difficulty is: \(difficulty.rawValue) with duration: \(difficulty.duration)")
        }
    }
    func togglePause() {
        if isPaused {
            if phase == .initialCountdown {
                startInitialCountdown()
            } else if phase == .exercise {
                startExerciseCountdown()
            }
            isPaused = false
        } else {
            exerciseTimer?.invalidate()
            isPaused = true
        }
    }

    
    func resetExercise() {
        exerciseTimer?.invalidate()
        countdownValue = 3
        phase = .initialCountdown
        isPaused = false
        startInitialCountdown()
    }
    
    func startInitialCountdown() {
        exerciseTimer?.invalidate()
        exerciseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.countdownValue > 1 {
                self.countdownValue -= 1
            } else {
                self.exerciseTimer?.invalidate()
                self.beginExercise()
            }
        }
    }

    func startExerciseCountdown() {
        exerciseTimer?.invalidate()
        exerciseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.countdownValue > 1 {
                self.countdownValue -= 1
            } else {
                self.exerciseTimer?.invalidate()
                self.finishExercise()
            }
        }
    }

    
    func beginExercise() {
        phase = .exercise
        countdownValue = difficulty.duration
        startExerciseCountdown()
    }


    
    func finishExercise() {
        phase = .finished
        countdownValue = 0
        exerciseTimer?.invalidate()
        exerciseTimer = nil

        // Show the TimesUpOverlayView
        self.showTimesUpOverlay = true
    }

}



struct ExercisePage_Previews: PreviewProvider {
    static var previews: some View {
        
        ExercisePage(difficulty: .medium, exerciseName: .constant("Sample Exercise"), completion: {_ in })
                .environmentObject(ExerciseLog.shared)
                .environmentObject(ViewRouter())
    }
}



