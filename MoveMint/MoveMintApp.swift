//
//  MoveMintApp.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//

import SwiftUI
import Firebase

class ViewRouter: ObservableObject {
    
    @Published var refreshKey: UUID = UUID()

    
    enum Page {
        case onboarding_1, signupView, onboarding_2, onboarding_3, mainTabView, mainSettingsView, animatedPicker, exercisePage, group11ContainerView  // Removed the period at the end.
    }
    
    @Published var currentPage: Page = .onboarding_1 {
        didSet {
            print("Transitioned from \(oldValue) to \(currentPage)")
        }
    }


    
}
@main
struct MoveMintApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
           
           ContentView()  // Use ContentView instead of MainTabView since it manages the routing
                    .environmentObject(viewRouter)
            .environmentObject(SelectedTabIndex())
            .environmentObject(DateManager())
        }
    }
}
