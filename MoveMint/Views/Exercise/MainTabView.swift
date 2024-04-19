//
//  MainTabView.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//

import SwiftUI
//
//class SelectedTabIndex: ObservableObject {
//    @Published var index: Int = 0
//}

class DateManager: ObservableObject {
    @Published var selectedDate: Date = Date()
}

struct MainTabView: View {
    //@EnvironmentObject var selectedTabIndex: SelectedTabIndex
    @EnvironmentObject var dateManager: DateManager
    @State private var selectedTab = 0
    //@Binding var path: NavigationPath
    //@EnvironmentObject var viewRouter: ViewRouter
    
    @State private var showSettings: Bool = false  // State for sheet presentation
    
    private let customGreen = Color(hex: "7BB38C")
    
    var body: some View {
//       
//            VStack {
//                CustomNavigationBar(title: "Stats", trailingAction: {
//                    showSettings.toggle()
//                })
//                
        TabView (selection: $selectedTab) {
            
            AnimatedPicker(completion: {
                
            })
            //selectedTabIndex.index = 1
            
            //.environmentObject(viewRouter)
            .tabItem {
                Image("Running")
            }
            .tag(0)
            
            
            //.tag(Tab.running)
            
            Group11ContainerView(exerciseLog: ExerciseLog.shared, completion: {
                //selectedTabIndex.index = 0
                
            })
            .tabItem {
                Image("Group 11")
            }
            .tag(1)
            .environmentObject(DateManager())
        }
                    .accentColor(customGreen)
                    .navigationBarBackButtonHidden(true)
                    //.environmentObject(viewRouter)
//                    .environmentObject(DateManager())
                   .environmentObject(ExerciseLog.shared)
                    
                    
                    }
                    //.tag(Tab.group11)
                }
                
               
                //                        .sheet(isPresented: $showSettings) {
                //                            MainSettingsView()
                // .environmentObject(viewRouter)
            
            
            
            //            .sheet(isPresented: $showSettings) {  // Present the MainSettingsView as a sheet
            //                MainSettingsView()
            //.environmentObject(viewRouter)  // Ensure viewRouter is passed
           // .environmentObject(SelectedTabIndex())
           
            
           
           
            
            
            
        
        
    
enum Tab: Int {
    case running = 1
    case group11 = 2
    
}
    private func tabImage(named name: String, forTab tab: Int) -> some View {
        Image(name)
            .renderingMode(.template)
            //.foregroundColor(selectedTabIndex.index == tab ? customGreen : .gray)
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
