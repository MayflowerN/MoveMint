//
//  Model.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//

import Foundation

struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let duration: String
    let difficulty: String
}

let sampleExercises: [Exercise] = [
    // Easy
    Exercise(name: "10 Jumping Jacks", duration: "30s", difficulty: "Easy"),
    Exercise(name: "5 Leg Swings each side", duration: "20s", difficulty: "Easy"),
    Exercise(name: "10 Arm Circles", duration: "20s", difficulty: "Easy"),
    Exercise(name: "20 High Knees", duration: "30s", difficulty: "Easy"),
    Exercise(name: "5 Slow Mountain Climbers", duration: "20s", difficulty: "Easy"),
    Exercise(name: "10s Plank", duration: "10s", difficulty: "Easy"),
    Exercise(name: "8 Squats", duration: "30s", difficulty: "Easy"),
    Exercise(name: "10 Standing Leg Lifts", duration: "20s", difficulty: "Easy"),
    Exercise(name: "5 Step-ups each leg", duration: "30s", difficulty: "Easy"),
    Exercise(name: "5 Wall Push-ups", duration: "20s", difficulty: "Easy"),
    Exercise(name: "10 Butt Kicks", duration: "20s", difficulty: "Easy"),
    Exercise(name: "5 Sit-ups", duration: "30s", difficulty: "Easy"),
    Exercise(name: "5 Knee Push-ups", duration: "30s", difficulty: "Easy"),
    Exercise(name: "10 Walking Lunges", duration: "40s", difficulty: "Easy"),
    Exercise(name: "10s Static Lunge hold", duration: "10s", difficulty: "Easy"),
    Exercise(name: "5 Side Leg Lifts each side", duration: "20s", difficulty: "Easy"),

    // Medium
    Exercise(name: "25 Push-ups", duration: "1m", difficulty: "Medium"),
    Exercise(name: "30 Alternating Lunges", duration: "1m", difficulty: "Medium"),
    Exercise(name: "20 Leg Raises", duration: "1m", difficulty: "Medium"),
    Exercise(name: "15 Burpees", duration: "1m", difficulty: "Medium"),
    Exercise(name: "30s Plank", duration: "30s", difficulty: "Medium"),
    Exercise(name: "12 Jump Squats", duration: "45s", difficulty: "Medium"),
    Exercise(name: "15 Tricep Dips", duration: "45s", difficulty: "Medium"),
    Exercise(name: "10 Pike Push-ups", duration: "1m", difficulty: "Medium"),
    Exercise(name: "15 Tuck Jumps", duration: "45s", difficulty: "Medium"),
    Exercise(name: "20 Russian Twists", duration: "30s", difficulty: "Medium"),
    Exercise(name: "15 Plank to Push-up", duration: "1m", difficulty: "Medium"),
    Exercise(name: "10 Single Leg Deadlifts each side", duration: "1m", difficulty: "Medium"),
    Exercise(name: "20 Mountain Climbers", duration: "30s", difficulty: "Medium"),
    Exercise(name: "15 Plank Jacks", duration: "30s", difficulty: "Medium"),
    Exercise(name: "30s Side Plank each side", duration: "1m", difficulty: "Medium"),

    // Hard
    Exercise(name: "50 Push-ups", duration: "2m", difficulty: "Hard"),
    Exercise(name: "40 Alternating Pistol Squats", duration: "3m", difficulty: "Hard"),
    Exercise(name: "30 Pull-ups", duration: "2m", difficulty: "Hard"),
    Exercise(name: "40 Box Jumps", duration: "2m", difficulty: "Hard"),
    Exercise(name: "1m Plank", duration: "1m", difficulty: "Hard"),
    Exercise(name: "20 Burpees with Push-up", duration: "2m", difficulty: "Hard"),
    Exercise(name: "30 Jumping Lunges", duration: "1m", difficulty: "Hard"),
    Exercise(name: "25 Decline Push-ups", duration: "2m", difficulty: "Hard"),
    Exercise(name: "1m30s Wall Sit", duration: "1m30s", difficulty: "Hard"),
    Exercise(name: "20 Dragon Flags", duration: "2m", difficulty: "Hard"),
    Exercise(name: "40 Wide Grip Push-ups", duration: "2m", difficulty: "Hard"),
    Exercise(name: "20 Handstand Push-ups", duration: "3m", difficulty: "Hard"),
    Exercise(name: "30 Tuck Jump Burpees", duration: "2m", difficulty: "Hard"),
    Exercise(name: "15 One-Arm Push-ups each side", duration: "3m", difficulty: "Hard"),
    Exercise(name: "50 V-ups", duration: "2m", difficulty: "Hard")
]


