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
  
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @EnvironmentObject var exerciseLog: ExerciseLog
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showTimesUpOverlay = false
    
    
    let difficulty: Difficulty
    @Binding var exerciseName: String
    
    init(difficulty: Difficulty, exerciseName: Binding<String>) {
        self.difficulty = difficulty
        self._exerciseName = exerciseName
        print("Initializer difficulty is: \(difficulty.rawValue)")
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
    
    var body: some View {
        
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
                    AvocadoGif("avocado")
                        .frame(width: 200, height: 200)
                    
                    if phase == .exercise {
                        Text("\(countdownValue)")
                            .font(Font.custom("Urbanist", size: 28).weight(.semibold))
                            .kerning(0.84)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: FinishedExerciseView(exerciseName: exerciseName, date: Date())) {
                        Image("greencheck")
                            .frame(width: 100, height: 100)
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
                .environmentObject(viewRouter)// Hides the back button
                

            if showSkipOverlay {
                ZStack {
                    Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                    
                    // Assuming ResetOverlayView is another View component you have
                    SkipOverlayView(onConfirm: {
                        // Handle skip confirmation
                        self.showAnimatedPicker = true
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
                AnimatedPicker()
                // Add any required actions or bindings you might need for AnimatedPicker
            }
            
            if showTimesUpOverlay {
                ZStack {
                    Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                    
                    TimesUpOverlayView(
                        exerciseName: exerciseName,
                        onConfirm: { /* ... */ },
                        onCancel: { /* ... */ },
                        onSkip: {
                            // Handle the skip action
                            self.showTimesUpOverlay = false
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        onComplete: markExerciseComplete,
                        navigateToFinishedExerciseView: $showFinishedExerciseView // <-- Corrected here
                    )
                }
            }
        }
        
        
        .onAppear {
            // Combine all your onAppear logic here
            startInitialCountdown()
            print("Initializer difficulty is: \(difficulty.rawValue)")
            print("Difficulty is: \(difficulty.rawValue) with duration: \(difficulty.duration)")
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
        
            ExercisePage(difficulty: .medium, exerciseName: .constant("Sample Exercise"))
                .environmentObject(ExerciseLog.shared)
                .environmentObject(ViewRouter())
    }
}



