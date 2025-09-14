//
//  MyLingoMatesApp.swift
//  MyLingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/26/25.
//

import SwiftUI
@main
struct MyLingoMatesApp: App {
    @State private var lessonData: LessonData? = LessonLoader.loadLessons()

    var body: some Scene {
        WindowGroup {
            ContentView(currentView: .firstpage, lessonData: lessonData)
        }
    }
}
