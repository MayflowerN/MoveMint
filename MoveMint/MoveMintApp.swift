//
//  MoveMintApp.swift
//  MoveMint
//
//  Created by Ellie on 9/12/23.
//

import SwiftUI
import Firebase

class ViewRouter: ObservableObject {
    
//    @Published var refreshKey: UUID = UUID()
//    @Published var currentPage: Page
//
//    
//    enum Page {
//        case onboarding_1, signupView, onboarding_2, onboarding_3, mainTabView, mainSettingsView, animatedPicker, group11ContainerView
//        case exercisePage(difficulty: Difficulty, exerciseName: String)  // Add this line
//    }
//    
//    
//    init() {
//        if Auth.auth().currentUser != nil {
//            // User is signed in. Navigate to the main tab view.
//            self.currentPage = .mainTabView
//        } else {
//            // No user is signed in. Show onboarding.
//            self.currentPage = .onboarding_1
//        }
//    }
//}
@main
struct MoveMintApp: App {
//    @StateObject var viewRouter = ViewRouter()
//    
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView2()  // Use ContentView instead of MainTabView since it manages the routing
            //                .environmentObject(viewRouter)
            //                .environmentObject(SelectedTabIndex())
            .environmentObject(DateManager())
        }
        }
    }
}
