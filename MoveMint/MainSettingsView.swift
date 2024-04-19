//
//  MainSettingsView.swift
//  MoveMint
//
//  Created by Ellie on 9/22/23.
//

//import SwiftUI
//import Firebase
//
//struct MainSettingsView: View {
//    @State private var userName: String = ""  // This will be loaded from the database (like Firebase) after sign up.
//    @State private var navigateToEditInfo: Bool = false
//    @State private var profilePicture: Image?  // Placeholder, you should fetch this from a data source.
//    @State private var navigateToChangePasswordView: Bool = false
//    @State private var navigateToLogoutView: Bool = false
//    
//    @State private var isLogoutOverlayVisible: Bool = false
//    @EnvironmentObject var viewRouter: ViewRouter
//
//
//    
//    var body: some View {
//       
//            VStack(spacing: 20) {
//                ZStack {
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 425, height: 220)
//                        .background(Color(red: 0.3, green: 0.73, blue: 0.61))
//                        .cornerRadius(30)
//                        .ignoresSafeArea()
//                    
//                    
//                    VStack {
//                        // Placeholder profile picture.
//                        if let userImage = profilePicture {
//                            userImage
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
//                                .clipShape(Circle())
//                                .padding(.top, 20)
//                        } else {
//                            Image(systemName: "person.circle.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
//                                .clipShape(Circle())
//                                .padding(.top, 20)
//                        }
//                        
//                        HStack {
//                            TextField("", text: $userName)
//                                .font(Font.custom("Spartan", size: 24).weight(.bold))
//                                .foregroundColor(.white)
//                                .disabled(true)
//                                .padding(.leading, 130)
//                            
//                            Button(action: { self.navigateToEditInfo.toggle() }) {
//                                Image("pencil")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20, height: 20)
//                                    .padding(.trailing, 130)
//                            }
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                }
//                
//                Button(action: { self.navigateToChangePasswordView.toggle() }) {
//                                 HStack {
//                                     Text("Change Password")
//                                         .font(Font.custom("Spartan", size: 16))
//                                         .kerning(0.48)
//                                         .foregroundColor(.black)
//                                         .frame(width: 206, alignment: .leading)
//                                     Spacer()
//                                     Image("chevron")
//                                         .frame(width: 10.2266, height: 24)
//                                 }
//                             }
//                .padding()
//                             .buttonStyle(PlainButtonStyle()) // Makes sure the entire button area is clickable
//
//                Button(action: { self.isLogoutOverlayVisible.toggle() }) {
//                    HStack {
//                        Text("Logout")
//                            .font(Font.custom("Spartan", size: 16))
//                            .kerning(0.48)
//                            .foregroundColor(.black)
//                            .frame(width: 206, alignment: .leading)
//                        Spacer()
//                        Image("chevron")
//                            .frame(width: 10.2266, height: 24)
//                    }
//                }
//                .padding()
//                .buttonStyle(PlainButtonStyle())
////                .overlay(
////                    Group {
////                        if isLogoutOverlayVisible {
////                            LogoutView(
////                                onConfirm: {
////                                    debugPrint("Perform logout here")
////                                    self.isLogoutOverlayVisible.toggle()
////                                    debugPrint("Logged out!")
////                                },
////                                onCancel: {
////                                    self.isLogoutOverlayVisible.toggle()
////                                
////                                },
////                                onLoggedOut: {
////                                   
////                                },
////                                isOverlayVisible: $isLogoutOverlayVisible
////                            )
////                            .environmentObject(viewRouter)  // Provide the viewRouter here
//                        }
//                    }
//                )
//
//
//                Button(action: {
//                    debugPrint("Back to Exercise button tapped!")
//                    viewRouter.currentPage = .mainTabView
//                    debugPrint("Current page after button tapped: \(viewRouter.currentPage)")
//                }) {
//                    
//                    /* Text("Back to Exercise")
//                     .font(
//                     Font.custom("Spartan", size: 24)
//                     .weight(.heavy)
//                     )
//                     .kerning(0.72)
//                     .foregroundColor(.white)
//                     }
//                     .padding(.horizontal, 30)
//                     .padding(.vertical, 33)
//                     .frame(width: 360, height: 79, alignment: .center)
//                     .background(Color(red: 0.22, green: 0.77, blue: 0.38))
//                     .cornerRadius(20)
//                     .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 4)*/
//                }
//
//                             Spacer()
//                
//                HStack {
//                    Text("Terms of Use")
//                      .font(Font.custom("Spartan", size: 12))
//                      .kerning(0.36)
//                      .underline()
//                      .foregroundColor(.black)
//                    Text("Private Policy")
//                      .font(Font.custom("Spartan", size: 12))
//                      .kerning(0.36)
//                      .underline()
//                      .foregroundColor(.black)
//                }
//
//                         }
//                         .padding()
//                         .sheet(isPresented: $navigateToEditInfo) {
//                             EditInfoPage().environmentObject(viewRouter)
//                         }
//                         .sheet(isPresented: $navigateToChangePasswordView) {
//                             ChangePasswordView().environmentObject(viewRouter)
//                         
//                         }
//                         .onAppear {
//                             fetchUserName()
//                         }
//                     
//                       
//      
//        .navigationBarBackButtonHidden(true)
//    
//        }
//    
//    
//    // Moved fetchUserName() function outside of the NavigationView body.
//    func fetchUserName() {
//        if let user = Auth.auth().currentUser {
//            // Here we're assuming the user's display name is what you want. Adjust as needed.
//            self.userName = user.displayName ?? "Unknown Name"
//        }
//    }
//}
//
//struct MainSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainSettingsView()
//    }
//}
//
