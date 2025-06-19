//
//  SignupView.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI

struct SignupView: View {
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView
    var body: some View {
        ZStack{
            Color(.white)
            //makes sure everything is colored including safe area
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Text("Welcome to LingoMates").font(.system(size: 32, weight: .bold)).padding(.top, 5)
                Text("What brings you here?").font(.system(size: 20,weight: .medium))
                    .padding(30)
                
                HStack{
                    Button(action: {
                        print("Picked option 1")
                        currentView = .onboarding
                    }) {
                        
                        Text("To connect with family")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1)
                    )
                }
                .padding(.top, 20)
                .padding(.horizontal, 15)
                
                HStack{
                Button(action: {
                    print("Picked option 2")
                    currentView = .onboarding
                }) {
                    
                    Text("I love learning languages")
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
            }
            .padding(.top, 20)
            .padding(.horizontal, 15)
                
                HStack{
                Button(action: {
                    print("Picked option 3")
                    currentView = .onboarding
                }) {
                    
                    Text("An upcoming trip")
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
            }
            .padding(.top, 20)
            .padding(.horizontal, 15)
                
                HStack{
                Button(action: {
                    print("Option 4")
                    currentView = .onboarding
                }) {
                    
                    Text("Other")
                        .foregroundColor(.black)

                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
            }
            .padding(.top, 20)
            .padding(.horizontal, 15)
            
            
                
            }
            Spacer()
            
        }
        
    }
}

#Preview {
    // Create a local state variable to pass as a Binding to the SignupView
    SignupView(currentView: .constant(.signUp))
}
