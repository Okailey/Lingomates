//
//  AgeView.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI

struct AgeView: View {
    @State private var selectedAge = 18 // default selection
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView
    
    var body: some View {
        ZStack{
            Color(.white)
            //makes sure everything is colored including safe area
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                // Age Picker
                Text("Age").font(.system(size: 32, weight: .medium))
                Picker("Age", selection: $selectedAge) {
                    ForEach(13..<100) { age in
                        Text("\(age)").tag(age)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                .clipped()
                .padding(.bottom, 100)
                
                Button("Next") {
                    currentView = .languageChoice
                    //                print("Name: \(name), Age: \(selectedAge), Email: \(email)")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.black)
                .cornerRadius(20)
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    AgeView(currentView: .constant(.ageView))
}
