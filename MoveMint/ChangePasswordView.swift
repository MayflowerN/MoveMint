//
//  ChangePasswordView.swift
//  MoveMint
//
//  Created by Ellie on 9/23/23.
//

import SwiftUI
import FirebaseAuth


struct ChangePasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmNewPassword: String = ""
    
    @State private var isCurrentPasswordVisible: Bool = false
    @State private var isNewPasswordVisible: Bool = false
    @State private var isConfirmNewPasswordVisible: Bool = false
    @State private var errorMessage: String?
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Password")
                .font(Font.custom("Spartan", size: 24).weight(.bold))
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            
            passwordField(title: "Current Password", password: $currentPassword, isVisible: $isCurrentPasswordVisible)
            
            passwordField(title: "New Password", password: $newPassword, isVisible: $isNewPasswordVisible)
            
            passwordField(title: "Confirm New Password", password: $confirmNewPassword, isVisible: $isConfirmNewPasswordVisible)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Button(action: saveChanges) {
                Text("Save Changes")
                    .font(Font.custom("Spartan", size: 24).weight(.heavy))
                    .foregroundColor(.white)
                    .frame(width: 360, height: 79)
                    .background(Color(red: 0.22, green: 0.77, blue: 0.38))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 4)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func passwordField(title: String, password: Binding<String>, isVisible: Binding<Bool>) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(Font.custom("Urbanist", size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                if isVisible.wrappedValue {
                    TextField("", text: password)
                        .padding(.trailing)
                } else {
                    SecureField("", text: password)
                        .padding(.trailing)
                }
                
                Button(action: { isVisible.wrappedValue.toggle() }) {
                    Image("eye")
                        .resizable()
                        .frame(width: 28.5699, height: 20)
                        .padding(10)
                }
            }
            .overlay(
                Rectangle().frame(height: 1).foregroundColor(.black),
                alignment: .bottom
            )
        }
    }
    
    private func saveChanges() {
        if newPassword == confirmNewPassword {
            if let user = Auth.auth().currentUser {
                user.updatePassword(to: newPassword) { (error) in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    } else {
                        // Successfully updated password
                        debugPrint("Password changed successfully!")
                    }
                }
            }
        } else {
            errorMessage = "Passwords don't match!"
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
