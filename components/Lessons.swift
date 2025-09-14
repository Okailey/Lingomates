//
//  Lessons.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import Foundation

struct LessonData: Codable {
    var lessons: [String: Lesson]
}

struct Lesson: Codable {
    var title: String
    var sections: Sections
//    var quiz: LessonQuiz  // Changed Quiz to LessonQuiz
}

struct Category: Identifiable, Codable {
    var id: String { category }
    let category: String
    let phrases: [String]
}

struct BasicIntroduction: Codable {
    let title: String
    let content: [Category]
}

struct Sections: Codable {
    var numbers: [String: String]?
    var alphabets: [String]?
    var basic_introduction: BasicIntroduction
}




