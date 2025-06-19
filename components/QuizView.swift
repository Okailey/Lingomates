import SwiftUI

struct QuizView: View {
    @State private var selectedOption: String? = nil
     @State private var showFeedback = false
     @State private var currentQuestionIndex = 0
    @State private var score = 0

     @Binding var currentView: AppView
     
     var lessonId: String = "lesson_1"
     
     @State private var lessonData: Quizzes? = nil
     @State private var isLoading = true
     
     // Update to reference the correct property name
     var currentQuiz: LessonQuiz? {
         return lessonData?.quizzes[lessonId]
     }
     
     var currentQuestion: QuizQuestion? {
         guard let quiz = currentQuiz else { return nil }
         return quiz.questions[safe: currentQuestionIndex]
     }
     
     // Load the quiz data asynchronously when the view appears
     func loadQuizData() {
         DispatchQueue.global().async {
             if let quizzes = QuizDataLoader.loadQuizzes() {
                 DispatchQueue.main.async {
                     self.lessonData = quizzes
                     self.isLoading = false
                 }
             } else {
                 DispatchQueue.main.async {
                     self.isLoading = false
                 }
             }
         }
     }
     
     var body: some View {
         ZStack {
             LinearGradient(
                     gradient: Gradient(colors: [Color.white, Color.white]),
                     startPoint: .topTrailing,
                     endPoint: .bottomLeading
                 )
                 .edgesIgnoringSafeArea(.all)
                 
             
             VStack {
                 Text("Let's see how much we retained")
                     .font(.title2)
                     .padding(.bottom, 20)
                 
                 if isLoading {
                     // Show loading indicator while data is being loaded
                     ProgressView("Loading...")
                         .progressViewStyle(CircularProgressViewStyle())
                         .padding()
                 } else if let quiz = currentQuestion {
                     Text(quiz.question)
                         .font(.title3)
                         .padding(.top)
                     
                     ForEach(quiz.options, id: \.self) { option in
                         Button(action: {
                             selectedOption = option
                             showFeedback = true
                             if option == currentQuestion?.answer {
                                     score += 1
                                 }
                         }) {
                             HStack {
                                 Text(option)
                                     .foregroundColor(.black)
                                     .padding()
                                     .frame(maxWidth: .infinity)
                             }
                             .background(Color.green)
                             .cornerRadius(15)
                             .overlay(
                                 RoundedRectangle(cornerRadius: 15)
                                     .stroke(Color.green, lineWidth: 1)
                             )
                         }
                         .disabled(showFeedback) // Disable options after answering
                     }
                     
                     if showFeedback {
                         if selectedOption == quiz.answer {
                             Text("✅ Correct!")
                                 .font(.headline)
                                 .foregroundColor(.green)
                                 .padding(.top, 10)
                         } else {
                             VStack {
                                 Text("❌ Incorrect")
                                     .font(.headline)
                                     .foregroundColor(.red)
                                 
                                 Text("Correct Answer: \(quiz.answer)")
                                     .font(.subheadline)
                                     .foregroundColor(.black)
                                     .padding(.top, 5)
                             }
                             .padding(.top, 10)
                         }
                         
                         Button(action: {
                             moveToNextQuestion()
                         }) {
                             Text("Next")
                                 .padding()
                                 .background(Color.green)
                                 .foregroundColor(.white)
                                 .cornerRadius(10)
                                 .padding(.top)
                         }
                     }
                 } else {
                     // End of quiz and show score
                     Text("Quiz Completed!")
                         .font(.largeTitle)
                         .padding()

                     Text("Your Score: \(score) / \(lessonData?.quizzes[lessonId]?.questions.count ?? 0)")
                         .font(.title2)
                         .padding()

                     Button(action: {
                         currentView = .homepage
                     }) {
                         Text("Go to Homepage")
                             .padding()
                             .background(Color.green)
                             .foregroundColor(.white)
                             .cornerRadius(10)
                     }
                     .padding(.top, 20)
                 }
                 
                 Spacer()
             }
             .padding()
         }
         .onAppear {
             loadQuizData()
         }
     }
     
     private func buttonColor(for option: String) -> Color {
         if showFeedback {
             if option == selectedOption {
                 return option == currentQuestion?.answer ? Color.green.opacity(0.5) : Color.red.opacity(0.5)
             }
         }
         return Color.green.opacity(0.3)
     }
     
     private func moveToNextQuestion() {
         selectedOption = nil
         showFeedback = false
         currentQuestionIndex += 1
         
         // If we are at the end of the quiz, show the result or navigate to the next screen
         if currentQuestionIndex >= (lessonData?.quizzes[lessonId]?.questions.count ?? 0) {
//             currentView = .homepage // Navigate to homepage after quiz completion
         }
     }
 }

 extension Array {
     subscript(safe index: Int) -> Element? {
         return indices.contains(index) ? self[index] : nil
     }
 }

 // Preview
 struct QuizView_Previews: PreviewProvider {
     static var previews: some View {
         QuizView(currentView: .constant(.quiz), lessonId: "lesson_1")
     }
 }
