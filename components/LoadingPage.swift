//
//  LoadingPage.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI

struct LoadingPage: View {
    @State private var progress = 0.0 // Progress value for the loading bar
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView
    
    var body: some View {
        VStack {
            // Image placed at the top
            Image("loading") // Replace "loading.png" with your actual image name
                .resizable() // Makes the image resizable
                .aspectRatio(contentMode: .fill) // Keeps the aspect ratio
                .frame(width: 200, height: 700) // Adjusts the size of the image

            // Progress bar at the bottom
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(height: 20)
                .padding(.top, 20)
                .padding(.bottom, 40) // Keeps some space from the bottom

            // Text message below the progress bar
            Text("Please wait while we prepare your experience.")
                .font(.headline)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Centers the content
        .background(Color.white) // Optional background color
        .edgesIgnoringSafeArea(.all) // Ensures the background fills the screen
        .onAppear {
            // Start the loading animation
            withAnimation(.linear(duration: 5)) {
                progress = 1.0 // Progress reaches 100% after 5 seconds
            }

            // After 5 seconds, navigate to the homepage
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                currentView = .homepage  // Navigate to the homepage
            }
        }
    }
}

#Preview {
    LoadingPage(currentView: .constant(.loading))
}
