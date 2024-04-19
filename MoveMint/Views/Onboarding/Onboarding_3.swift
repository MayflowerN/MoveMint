//
//  Onboarding_3.swift
//  MoveMint
//
//  Created by Ellie on 9/18/23.
//

import SwiftUI

struct Onboarding_3: View {
    //@EnvironmentObject var viewRouter: ViewRouter
    //@Binding var path: NavigationPath
    var body: some View {
        
        VStack(spacing: 20) {
            HStack {
                Text("MoveMint")
                    .font(
                        Font.custom("Spartan", size: 40)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.22, green: 0.77, blue: 0.38))
                Image("leaf")
                    .frame(width: 47.36842, height: 45)
            }
            Text("Stay Active everyday!")
                .font(Font.custom("Spartan", size: 28))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            Text("Get ready to embark on a journey towards a healthier and happier you.")
                .font(Font.custom("Spartan", size: 20))
                .kerning(0.6)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
                .frame(width: 351, alignment: .top)
            Image("avocado")
                .resizable()
                .frame(width: 200, height: 200)
            NavigationLink(destination: MainTabView()) {
                Text("Get Started")
                    .font(Font.custom("Spartan", size: 24).weight(.heavy))
                    .kerning(0.72)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 33)
                    .frame(width: 360, height: 79, alignment: .center)
                    .background(Color(red: 0.22, green: 0.77, blue: 0.38))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.08), radius: 17.5, x: 0, y: 4)
            }
//            .navigationDestination(for: String.self) { value in
//                Text("This is screen number \(2)")
                
            }
            // .navigationBarHidden(true)
            .padding() // Add padding for better layout
        }
    }



