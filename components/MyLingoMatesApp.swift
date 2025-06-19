//
//  MyLingoMatesApp.swift
//  MyLingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/26/25.
//

import SwiftUI

@main
struct MyLingoMatesApp: App {
    // Load the lessons data on app startup
       @State private var lessonData: LessonData? = LessonLoader.loadLessons()

       var body: some Scene {
           WindowGroup {
               // Check if lessonData is available and pass the lesson to ContentView
               if let lesson_1 = lessonData?.lessons["lesson_1"] {
                   ContentView(theLesson: lesson_1)
               } else {
                   // Show a fallback UI if the lesson is not found
                   Text("Lesson not found")
                       .padding()
                       .font(.title)
               }
           }
       }
   }
