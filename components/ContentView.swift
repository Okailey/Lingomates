//
//  ContentView.swift
//  MyLingoMates
//
//  Created by Danielle Naa Okailey Quaye on 9/13/25.
//

// ContentView.swift
import SwiftUI

// Enum to track which screen to show
enum AppView {
    case firstpage       // Your startup/loading page
    case login            // Login screen
    case signUp           // Sign up screen
    case onboarding      // Onboarding flow (age, difficulty, etc.)
    case difficultyChoice
    case ageView
    case languageChoice
    case goalView
    case loading     // Short loading before homepage
    case homepage            // Main homepage
    case lessons(Lesson) // Individual lesson
    case quiz // quiz
    
}


struct ContentView: View {
    @State var currentView: AppView = .firstpage
    @State var lessonData: LessonData? = LessonLoader.loadLessons() // load once here

    var body: some View {
        switch currentView {
        case .firstpage:
            FirstPage(currentView: $currentView)
        case .login:
            LoginView(currentView: $currentView)
        case .signUp:
            SignupView(currentView: $currentView)
        case .onboarding:
            OnboardingView(currentView: $currentView)
        case .loading:
            LoadingPage(currentView: $currentView)
        case .homepage:
            // Pass lessonData to HomepageView
            HomepageView(currentView: $currentView, lessonData: lessonData)
        case .lessons(let lesson):
            LessonsView(theLesson: lesson, currentView: $currentView)
        case .quiz:
            QuizView(currentView: $currentView)
        case .difficultyChoice:
            DifficultyChoice(currentView: $currentView)
        case .ageView:
            AgeView(currentView: $currentView)
        case .languageChoice:
            LanguageChoice(currentView: $currentView)
        case .goalView:
            GoalView(currentView: $currentView)
        }
    }
}
