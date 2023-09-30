//
//  ScrollableCalendarView.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//
import SwiftUI

struct ScrollableCalendarView: View {
    @EnvironmentObject var dateManager: DateManager
    @ObservedObject var exerciseLog: ExerciseLog
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) { // Standard spacing for all items
                        ForEach(0..<30, id: \.self) { offset in
                            let date = Calendar.current.date(byAdding: .day, value: offset, to: Date())!
                            
                            DateCircleView(date: date, isSelected: isDate(date, equalTo: dateManager.selectedDate), exerciseLog: exerciseLog)
                                .onTapGesture {
                                    dateManager.selectedDate = date
                                }
                        }
                    }
                    .padding(.horizontal, 20) // Fixed horizontal padding
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
            
    }
    func getPaddingForSelectedDate(in width: CGFloat) -> CGFloat {
        let daysToShow = 30
        let totalWidth = CGFloat(daysToShow) * width / CGFloat(daysToShow)
        return max(0, (totalWidth - width) / 2)
    }

    func getOffsetForSelectedDate(in width: CGFloat) -> CGFloat {
        let selectedIndex = dateManager.selectedDate.timeIntervalSinceNow / (24*60*60)
        let centerOffset = (width / 2) - ((width / 30) / 2) // half of the parent view width minus half of a date circle width
        return centerOffset - CGFloat(selectedIndex) * (width / 30) // Move back by the number of days since now * width of a date circle
    }
    
    // Function to compare only the day, month, and year components of two dates
    func isDate(_ date1: Date, equalTo date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}
func normalizedDate(from date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components) ?? date
}


extension Color {
    static let customGreen = Color(red: 56/255, green: 197/255, blue: 98/255)
}

struct ScrollableCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableCalendarView(exerciseLog: ExerciseLog.shared)
            .environmentObject(DateManager())  // Provide the environment object for previews
    }
}



