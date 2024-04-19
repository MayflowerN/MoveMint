//
//  AnimatedPicker.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//

import SwiftUI

//enum ExerciseNavigation: String, Hashable {
//    case detailPost
//}

struct AnimatedPicker: View {
    @State private var offset: CGFloat = 0
    @State private var isSpinning: Bool = false
    @State private var selectedDifficulty: Difficulty = Difficulty.easy
    @State private var showExerciseButton: Bool = false
    @State private var spinButton: Bool = false
    @State private var exerciseName: String = ""
    @State private var presentExerciseView = false
    @State private var presentAnotherExercisePicker = false
    var exerciseLog = ExerciseLog.shared
    
    var completion: () -> ()
    
    private let itemHeight: CGFloat = 40
    private let timerInterval = 0.05
    private let highlightColor = Color(hex: "B9DABF")
    
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    private var maxOffset: CGFloat {
        CGFloat(currentExercises.count) * itemHeight
    }
    
    // Assuming you have this array elsewhere in your code
    private var currentExercises: [Exercise] {
        sampleExercises.filter { $0.difficulty == selectedDifficulty.id }
        // assuming the `Exercise` struct uses the 'id' (rawValue) of the enum for its 'difficulty' property
    }
    private var chosenExercise: Exercise {
        let index = (Int(offset / itemHeight) + 1) % currentExercises.count
        return currentExercises[index]
    }
    
    
    
    //@State private var path  = NavigationPath()
    
    
    var body: some View {
       
            VStack {
                
                if spinButton {
                    Text("Start Exercise Now")
                        .font(
                            Font.custom("Spartan", size: 24)
                                .weight(.bold)
                        )
                        .padding(.top, 20)
                        .foregroundColor(.black)
                } else {
                    Text("Spin to Choose an Exercise.")
                        .font(
                            Font.custom("Spartan", size: 24)
                                .weight(.bold)
                        )
                        .padding(.top, 20)
                        .foregroundColor(.black)
                        .onTapGesture {
                            startSpinning()
                        }
                    
                }
                
                // Horizontal Buttons for choosing difficulty
                Spacer()
                HStack(alignment: .center, spacing: 10) {
                    ForEach(Difficulty.allCases, id: \.self) { difficulty in
                        Button(action: {
                            selectedDifficulty = difficulty
                        }) {
                            Text(difficulty.id) // using 'id' because your global enum conforms to Identifiable
                        }
                        
                        
                        .padding(.horizontal, 22)
                        .padding(.vertical, 12) // Adjusted to fit properly
                        .background(selectedDifficulty == difficulty ? Color(red: 0.89, green: 0.95, blue: 0.89) : Color.clear)
                        .cornerRadius(24)
                    }
                }
                .padding(.bottom, 30)
                
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(currentExercises) { exercise in
                            Text(exercise.name)
                                .frame(height: itemHeight)
                                .background(Color.white)
                        }
                        // Repeating the list to simulate infinite scrolling
                        ForEach(currentExercises) { exercise in
                            Text(exercise.name)
                                .frame(height: itemHeight)
                                .background(Color.white)
                        }
                    }
                    
                    .offset(y: -offset)
                }
                .overlay(
                    Rectangle()
                        .fill(highlightColor)
                        .frame(height: itemHeight)
                        .opacity(0.5),
                    alignment: .center
                )
                
                .frame(width: 200, height: itemHeight * 3)
                .clipped()
                .border(Color.gray)
                Spacer()
                
                if showExerciseButton {
                    StyledButton(text: "Start Exercise") {
                        // Your current logic for starting the exercise
                        self.presentExerciseView = true
                    }
                } else {
                    StyledButton(text: isSpinning ? "Spinning..." : "Spin", action: {
                        if !isSpinning {
                            startSpinning()
                        }
                        // No action if isSpinning is true, to prevent multiple spins at the same time
                    })
                }
            }
            .fullScreenCover(isPresented: $presentExerciseView, content: {
                ExercisePage(difficulty: selectedDifficulty, exerciseName: .constant(chosenExercise.name), completion: { shouldGoToIndex1 in
                    self.resetSpinner() // Reset spinner once the exercise page is dismissed
                    if shouldGoToIndex1 {
                        self.completion()  
                    }
                })
            })

            .padding(.bottom, 25)
            //            .navigationDestination(for: ExerciseNavigation.self, destination: { navigation in
            //                switch navigation {
            //                case .detailPost:
            //                    break
            //                }
            //            })
    }
    func resetSpinner() {
        isSpinning = false
        showExerciseButton = false
        spinButton = false
    }

    
    func startSpinning() {
        // Cancel previous work item if it was still spinning
        spinningWorkItem?.cancel()
        
        // Create a new work item for the spin logic
        let workItem = DispatchWorkItem {
               let randomIterations = Int.random(in: 5...15)
               var currentIteration = 0
               
               func spinOnce() {
                   DispatchQueue.main.async {
                       withAnimation(.linear(duration: self.timerInterval)) {
                           self.offset += self.itemHeight
                           if self.offset >= self.maxOffset - (self.itemHeight * 2) {
                               self.offset = 0
                           }
                       }
                       currentIteration += 1
                       
                       if currentIteration < randomIterations {
                           DispatchQueue.main.asyncAfter(deadline: .now() + self.timerInterval, execute: spinOnce)
                       } else {
                           DispatchQueue.main.async {
                               self.isSpinning = false
                               self.showExerciseButton = true
                               self.spinButton = true
                               self.exerciseName = self.chosenExercise.name
                           }
                       }
                   }
               }
               
               // Start the first spin
               spinOnce()
           }
        
        // Store the new work item
        spinningWorkItem = workItem
        
        // Execute the work item
        DispatchQueue.global().async(execute: workItem)
    }
    
    @State private var spinningWorkItem: DispatchWorkItem?

}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct AnimatedPicker_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedPicker(completion: { }).environmentObject(ViewRouter())
    }
}


