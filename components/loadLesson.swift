//
//  loadLesson.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/23/25.
//

import Foundation

class LessonLoader {
    static func loadLessons() -> LessonData? {
        // Assuming the JSON file is named "lessons.json" and is included in your Xcode project
        guard let url = Bundle.main.url(forResource: "lessons", withExtension: "json") else {
            print("JSON file not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let lessonData = try decoder.decode(LessonData.self, from: data)
            return lessonData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}



