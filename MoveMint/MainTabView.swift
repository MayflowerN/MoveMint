//
//  MainTabView.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//

import SwiftUI

class SelectedTabIndex: ObservableObject {
    @Published var index: Int = 0
}

class DateManager: ObservableObject {
    @Published var selectedDate: Date = Date()
}

struct MainTabView: View {
    @EnvironmentObject var selectedTabIndex: SelectedTabIndex
    @EnvironmentObject var dateManager: DateManager
    @StateObject var viewRouter = ViewRouter()
    
    @State private var showSettings: Bool = false  // State for sheet presentation
    
    private let customGreen = Color(hex: "7BB38C")
    
    var body: some View {
        
            TabView(selection: $selectedTabIndex.index) {
                AnimatedPicker()
                    .environmentObject(viewRouter)
                    .tabItem {
                        tabImage(named: "Running", forTab: 0)
                    }
                    .tag(0)
                
                Group11ContainerView(exerciseLog: ExerciseLog.shared)
                    .environmentObject(viewRouter)
                    .environmentObject(DateManager())
                    .environmentObject(ExerciseLog.shared)
                  
                    .tabItem {
                        tabImage(named: "Group 11", forTab: 1)
                    }
                    .tag(1)
            }
        
            .accentColor(customGreen)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: Button(action: {
                showSettings.toggle()  // Toggle the sheet presentation
            }) {
                Image("gear")
            })
            .sheet(isPresented: $showSettings) {  // Present the MainSettingsView as a sheet
                MainSettingsView().environmentObject(viewRouter)
            
        }
    }

    private func tabImage(named name: String, forTab tab: Int) -> some View {
        Image(name)
            .renderingMode(.template)
            .foregroundColor(selectedTabIndex.index == tab ? customGreen : .gray)
    }
}



extension Color {
    init(fromHex hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (123, 179, 140)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: 1
        )
    }
}
