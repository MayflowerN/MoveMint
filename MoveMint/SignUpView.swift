//
//  SignUpView.swift
//  MoveMint
//
//  Created by Ellie on 9/18/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
            
            Text("Create an Account")
                .font(Font.custom("Spartan", size: 28))
                .foregroundColor(.black)
            
            infoTextField(placeHolder: "Name", text: $name)
            infoTextField(placeHolder: "Email", text: $email)
            infoTextField(placeHolder: "Create Password", text: $password, isSecure: true)
            infoTextField(placeHolder: "Confirm Password", text: $confirmPassword, isSecure: true)
            
            Button(action: {
                self.signUp()
            }) {
                Text("Sign Up")
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
    }
    func signUp() {
        if password != confirmPassword {
            alertMessage = "Passwords do not match"
            showAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                return
            }
            
            if let user = Auth.auth().currentUser {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = self.name
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        // Handle any errors here.
                        print("Failed to set display name: \(error.localizedDescription)")
                        return
                    }
                    print("Successfully set display name!")
                }
            }
            
            print("Successfully signed up!")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
