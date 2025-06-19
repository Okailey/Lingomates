//
//  OnboardingView.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var name = ""
    @State private var email = ""
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView
    
    var body: some View {
        ZStack{
            Color(.white)
            //makes sure everything is colored including safe area
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Tell us about yourself")
                    .font(.system(size: 32, weight: .bold)).padding(20)
                
                TextField("Name", text: $name)
                    .padding(20).background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.horizontal, 15)
                    .padding(.top, 40)
                
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(20).background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.horizontal, 15)
                    .padding(.top, 40)
                
                Button(action: {
                    print("next clicked ")
                    currentView = .ageView
                })
                {
                    HStack{
                        Text("Next")
                            .foregroundColor(.black)
                            .bold()
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
                                .padding(.top, 60)
                                .padding(.horizontal, 15)
                
                
                        
                    }
                }
                    
            
            }
        }

#Preview {
    // Create a dummy Binding to simulate the parent view's currentView state for preview
    OnboardingView(currentView: .constant(.onboarding))
}
