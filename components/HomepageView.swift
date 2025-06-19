//
//  HomepageView.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI

struct HomepageView: View {
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView

    @State private var selectedLesson: String? = nil
    @State private var navigateToLessons = false
    @State private var lessonData: LessonData? = LessonLoader.loadLessons()
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 60)
                
                // App Logo or Avatar
                Image("flags")
                    .resizable()
                    .frame(width: 300, height: 200)
                    .padding(.bottom, 10)
                
                Text("Here are some fun, bite-sized lessons that fit into your schedule.")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 2)
                
              
                    VStack(spacing: 20) {
                        ProgressiveChart(completedLesson: 0, allLessons: 10, streaks: 0)
                        
                        lessonButton(title: "Lesson 1", locked: false)
                        lessonButton(title: "Lesson 2", locked: true)
                        lessonButton(title: "Lesson 3", locked: true)
                        lessonButton(title: "Lesson 4", locked: true)
                        lessonButton(title: "Lesson 5", locked: true)
                        lessonButton(title: "Lesson 6", locked: true)
                        lessonButton(title: "Lesson 7", locked: true)
                        lessonButton(title: "Lesson 8", locked: true)
                        lessonButton(title: "Lesson 9", locked: true)
                        lessonButton(title: "Lesson 10", locked: true)
                    }
                    .padding(.top, 20)
                }
                
                Divider()
                
                // Bottom navigation bar
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home").font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile").font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "gearshape.fill")
                        Text("Settings").font(.caption)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color.white.shadow(radius: 2))
            }
            
            // Conditionally navigate to LessonsView
                        if currentView == .lessons {
                            if let lessonName = selectedLesson,
                               let lesson = lessonData?.lessons[lessonName] {
                                LessonsView(theLesson: lesson, currentView: $currentView)
                            } else {
                                Text("Lesson not found")
                            }
                        }
                    }
                }
    // MARK: - Lesson Button Component
    private func lessonButton(title: String, locked: Bool) -> some View {
        Button(action: {
            if !locked {
                selectedLesson = title // Store the selected lesson
                self.currentView = .lessons // Change to lessons view
            }
        }) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                    .bold()
                Image(systemName: locked ? "lock.fill" : "lock.open.fill")
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
        .padding(.horizontal, 15)
    }
}

// Preview
#Preview {
    HomepageView(currentView: .constant(.homepage))
}
//struct ProgressChartView: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text("Your Progress")
//                .font(.headline)
//
//            HStack {
//                VStack {
//                    Text("XP")
//                    Text("120").bold()
//                    ProgressView(value: 0.6)
//                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
//                }
//
//                VStack {
//                    Text("Streak")
//                    Text("5 Days").bold()
//                    ProgressView(value: 0.5)
//                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
//                }
//
//                VStack {
//                    Text("Lessons")
//                    Text("3/10").bold()
//                    ProgressView(value: 0.3)
//                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
//                }
//            }
//            .padding(.horizontal)
//        }
//        .padding()
//        .background(Color(.systemGray6))
//        .cornerRadius(15)
//        .padding(.horizontal)
//    }
//}
