//
//  SignInView.swift
//  MoveMint
//
//  Created by Ellie on 9/21/23.
//

import SwiftUI
import FirebaseAuth


struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToMain = false
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
                Text("Log In")
                    .font(Font.custom("Spartan", size: 28))
                    .foregroundColor(.black)
                infoTextField(placeHolder: "Email", text: $email)
                infoTextField(placeHolder: "Create Password", text: $password, isSecure: true)
                Button(action: {
                    self.signIn()
                }) {
                    Text("Sign In")
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
            NavigationLink(destination: MainTabView(), isActive: $navigateToMain) {
                            EmptyView()
                        }
                HStack(spacing: 5) {
                    Text("Don't have an account?")
                        .font(Font.custom("Spartan", size: 16))
                        .kerning(0.48)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up now")
                            .font(Font.custom("Spartan", size: 16))
                            .kerning(0.48)
                            .foregroundColor(Color.blue)  // You can adjust this color to your preference
                    }
                }
            }
        }
            
    func signIn() {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print("Error signing in: \(error)")
                    return
                }
                // User signed in successfully
                self.navigateToMain = true  // Activate the NavigationLink
        

            // User signed in successfully
            // TODO: Handle the successful login, perhaps by navigating to another view
        }
    }
  
    func infoTextField(placeHolder: String, text: Binding<String>, isSecure: Bool = false) -> some View {
        if isSecure {
            return AnyView(
                SecureField(placeHolder, text: text)
                    .padding(.horizontal)
                    .frame(width: 360, height: 56)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 1)
                    )
            )
        } else {
            return AnyView(
                TextField(placeHolder, text: text)
                    .padding(.horizontal)
                    .frame(width: 360, height: 56)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 1)
                    )
            )
        }
    }
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
