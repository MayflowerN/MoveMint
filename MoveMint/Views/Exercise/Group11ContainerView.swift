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
    var completion: () -> ()
    
    var body: some View {
        VStack {
            ScrollableCalendarView(exerciseLog: exerciseLog)
            
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    let exercises = exerciseLog.exercises(on: normalizedDate(from: dateManager.selectedDate))
                    if let exercises = exercises, !exercises.isEmpty {
                        ForEach(exercises.indices, id: \.self) { index in
                            VStack {
                                HStack {
                                    Image("running 1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50) // Adjust size as needed
                                        .alignmentGuide(.leading) { d in d[.leading] }
                                        .padding(.leading, 10)
                                    Text(exercises[index])
                                        .font(
                                            Font.custom("Urbanist", size: 24)
                                                .weight(.semibold)
                                        )
                                        .kerning(0.72)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image("greencheck")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60) // Adjust size as needed
                                        .alignmentGuide(.trailing) { d in d[.trailing] }
                                        .padding(.trailing, 10)
                                }
                            }
                            .frame(width: 380, height: 95)
                            .background(Color.white) // Start as invisible
                            .cornerRadius(21)
                            .overlay(
                                RoundedRectangle(cornerRadius: 21)
                                    .stroke(Color.clear, lineWidth: 1)
                            )
                            .padding(.bottom, 10) // add some spacing between the rectangles
                            .id(index)
                            .onAppear {
                                // Trigger opacity to full when the item appears
                                withAnimation {
                                    scrollViewProxy.scrollTo(exercises.count - 1, anchor: .bottom)
                                }
                            }
                        }
                        .onChange(of: exercises.count) { _ in
                            // Whenever the count changes, we should scroll to the bottom
                            withAnimation {
                                scrollViewProxy.scrollTo(exercises.count - 1, anchor: .bottom)
                            }
                        }
                    } else {
                        // No exercises for this date, so render an empty view
                        EmptyView()
                    }
                }
                
            }
            
            .navigationBarTitle("Stats", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                navigateToSettings = true
            }) {
                Image("gear") // Ensure this image is correctly named and exists
            })
            
            Button(action: {
                completion()
            }, label: {
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
            })
            
            .padding(.bottom, 100)
        }
        .background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
        .padding(.top, 15)
        
        
        
    }
    
    struct Group11ContainerView_Previews: PreviewProvider {
        static var previews: some View {
            Group11ContainerView(exerciseLog: ExerciseLog(), completion: {})
                .environmentObject(DateManager()) // Assuming you have a DateManager Environment Object
        }
    }
    
    
    
    
    //.navigationBarHidden(true)
}





