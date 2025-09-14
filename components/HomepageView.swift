//
//  HomepageView.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI

struct HomepageView: View {
    @Binding var currentView: AppView
    var lessonData: LessonData? // passed from ContentView

    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 60)

                    // App Logo
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

                        ForEach(1...10, id: \.self) { i in
                            lessonButton(title: "Lesson \(i)", locked: i != 1)
                        }
                    }
                    .padding(.top, 20)

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
            }
        }
    }

    // MARK: - Lesson Button
    private func lessonButton(title: String, locked: Bool) -> some View {
        Button(action: {
            if !locked, let lesson = lessonData?.lessons["lesson_1"] {
                currentView = .lessons(lesson) // ContentView will show LessonsView
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
    HomepageView(currentView: .constant(.homepage), lessonData: LessonLoader.loadLessons())
}


