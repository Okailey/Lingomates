//
//  Quiz.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//


import Foundation

struct Quizzes: Codable {
    // The key is a string (e.g., "lesson_1"), and the value is a LessonQuiz
    let quizzes: [String: LessonQuiz]
}

struct LessonQuiz: Codable  {
    let title: String
    let questions: [QuizQuestion]
}

struct QuizQuestion: Codable {
    let question: String
    let options: [String]
    let answer: String
}
