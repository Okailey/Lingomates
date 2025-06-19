//
//  LanguageChoice.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI

struct LanguageChoice: View {
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView
    var body: some View {
        ZStack{
            Color(.white)
            //makes sure everything is colored including safe area
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Text("What language do you want to learn?").font(.system(size: 20, weight: .medium))
                    .padding(.top, 200)
                
                
                Button(action: {
                    print("Clicked 1")
                    currentView = .difficultyChoice
                    
                })
                {
                    HStack{
                        Text("Twi")
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
                                .padding(.top, 40)
                                .padding(.horizontal, 15)
                
                
                Button(action: {
                    print("Clicked 2")
                })
                {
                    HStack{
                        Text("Ga")
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
                                .padding(.top, 40)
                                .padding(.horizontal, 15)
                
                Button(action: {
                    print("Clicked 3")
                })
                {
                    HStack{
                        Text("Ewe")
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
                                .padding(.top, 40)
                                .padding(.horizontal, 15)
                
                
                        
                        Spacer()
                        
                        
                    }
                    
                    
                }
                
            }
        }
   
#Preview {
    LanguageChoice(currentView: .constant(.languageChoice))
}
