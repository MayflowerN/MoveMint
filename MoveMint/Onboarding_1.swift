//
//  Onboarding_1.swift
//  MoveMint
//
//  Created by Ellie on 9/18/23.
//

import SwiftUI

struct Onboarding_1: View {
    @EnvironmentObject var viewRouter: ViewRouter

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
                
                Text("Welcome to MoveMint!")
                    .font(Font.custom("Spartan", size: 28))
                    .foregroundColor(.black)
                
                Text("Get ready to embark on a journey towards a healthier and happier you.")
                    .font(Font.custom("Spartan", size: 20))
                    .kerning(0.6)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
                    .frame(width: 351, alignment: .top)
                
                Button(action: {
                    viewRouter.currentPage = .signupView
                }) {
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

                
                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .font(Font.custom("Spartan", size: 16))
                        .kerning(0.48)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
                    
                    NavigationLink(destination: SignInView()) {
                        Text("Sign in now")
                            .font(Font.custom("Spartan", size: 16))
                            .kerning(0.48)
                            .foregroundColor(Color.blue)
                    }
                }
            
        }
        //.navigationBarHidden(true)
        .padding() // This will give some space around your VStack
    }
}

struct Onboarding_1_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding_1()
    }
}
