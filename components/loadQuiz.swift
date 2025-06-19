//
//  loadQuiz.swift
//  MyLingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/26/25.
//

import Foundation
class QuizDataLoader {
    static func loadQuizzes() -> Quizzes? {
        // Assuming the JSON file is named "lessons.json" and is included in your Xcode project
        guard let url = Bundle.main.url(forResource: "quizzes", withExtension: "json") else {
            print("JSON file not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let quizzes = try decoder.decode(Quizzes.self, from: data)
            return quizzes
        } catch {
            print("Failed to decode quizzes.json: \(error.localizedDescription)")
            return nil
        }
    }
}
