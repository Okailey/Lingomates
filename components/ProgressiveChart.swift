//
//  ProgressiveChart.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/23/25.
//


import Foundation
import SwiftUI


//create a struct for this
struct ProgressiveChart : View {
    var completedLesson: Int //completed lesson count
    var allLessons : Int //num of lessons in total
    var streaks : Int //streaks that you get per day when you log in
    
    var body: some View {
        ZStack{
            Color(.white)
            //makes sure everything is colored including safe area
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(/*alignment: .leading*/) {
                // Title for the progress section
                Text("Your Progress")
                    .font(.headline)
                
                // Progress view for lessons completed
                ProgressView(value: Double(completedLesson), total: Double(allLessons))
                    .accentColor(.green) // Set progress bar color to green
                    .padding(.vertical, 5)
                
                // Display the number of completed lessons
                Text("\(completedLesson) out of \(allLessons) lessons complete. You got this!")
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Divider() // Divider between sections
                
                // Streaks section
                VStack {
                    Text("Streaks")
                        .font(.headline)
                    
                    // Display the number of streak days
                    Text("\(streaks) Days")
        
                    // Progress bar for the streak, showing progress towards 7 days
                    ProgressView(value: Double(streaks), total: 7)
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange)) // Set progress bar color to orange
                }
                .padding(.vertical)
            }
            .padding(.horizontal, 15) // Padding for horizontal spacing
            .padding(.vertical, 15) // Padding for vertical spacing
            .background(Color(.white)) // Light gray background for the whole view
            .cornerRadius(15) // Rounded corners for the background
            .shadow(radius: 10) // Add a subtle shadow for visual depth
        }
    }
    
    struct ProgressiveChart_Previews: PreviewProvider {
        static var previews: some View {
            ProgressiveChart(completedLesson: 0, allLessons: 10, streaks: 0)
        }
    }
    
}
