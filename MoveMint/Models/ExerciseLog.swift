//
//  ExerciseLog.swift
//  MoveMint
//
//  Created by Ellie on 9/15/23.
//
import Foundation

class ExerciseLog: ObservableObject {
    static let shared = ExerciseLog() // Singleton instance
    
    @Published var recordedExercises: [String: [String]] = [:] // Date stored as "YYYY-MM-DD" String
    
    func addExercise(_ exercise: String, on date: Date) {
        let normalized = normalizedDate(from: date)
        let dateString = string(from: normalized)

        var existingExercises = recordedExercises[dateString] ?? []
        existingExercises.append(exercise)
        recordedExercises[dateString] = existingExercises
        
        // Save to UserDefaults
        if let data = try? JSONEncoder().encode(recordedExercises) {
            UserDefaults.standard.set(data, forKey: "recordedExercises")
        }
    }
    
    func exercises(on date: Date) -> [String]? {
        let dateString = string(from: date)
        return recordedExercises[dateString]
    }
    
    func firstDate() -> Date {
        let dates = recordedExercises.keys.compactMap(self.date)
        
        return dates.sorted().first ?? Date()
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "recordedExercises"),
           let savedExercises = try? JSONDecoder().decode([String: [String]].self, from: data) {
            self.recordedExercises = savedExercises
        }
    }

    func normalizedDate(from date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components) ?? date
    }
}

extension ExerciseLog {
    private func string(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func date(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }
}
