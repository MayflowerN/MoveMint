//
//  DateCircleView.swift
//  MoveMint
//
//  Created by Ellie on 9/15/23.
//
import SwiftUI

struct DateCircleView: View {
    let date: Date
    let isSelected: Bool
    @ObservedObject var exerciseLog: ExerciseLog
    
    var body: some View {
        VStack(spacing: 10) {
                    VStack(alignment: .center, spacing: 5) { // Adjusted alignment and spacing
                        Text(dayString(from: date).uppercased())
                            .font(isSelected ? .caption : .caption2) // Adjust font based on selection
                            .foregroundColor(isSelected ? .customGreen : .black)
                        
                        Text(String(calendar.component(.day, from: date)))
                            .font(isSelected ? .title3 : .headline) // Adjust font based on selection
                            .foregroundColor(isSelected ? .customGreen : .black)
                    }
                    .padding(isSelected ? 18 : 15) // Adjust padding based on selection
                    .background(
                        Circle()
                            .stroke(isSelected ? Color.customGreen : Color.gray.opacity(0.2), lineWidth: isSelected ? 3 : 2)
                            .frame(width: isSelected ? 70 : 60, height: isSelected ? 70 : 60) // Size adjustments for selected circle
                    )
                }
            }

    private var calendar: Calendar {
        return .current
    }

    func dayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}


