//
//  LessonsView.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/20/25.
//

import SwiftUI
import AVFoundation

struct LessonsView: View {
    @State private var lesson: Lesson?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @State private var timer: Timer?
    @State private var showCongrats = false
    @State private var navigateNext = false
    @State private var showButton = false
    @State private var scrollOffset: CGFloat = 0
    //    var lessonState: Quizzes
    var theLesson: Lesson
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView
    
    var body: some View {
        ZStack {
            backgroundView
            ScrollView {
                lessonContent
            }
            floatingButton
            congratulationsOverlay
        }
    }
    
    private var backgroundView: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.green]), startPoint: .top, endPoint: .bottom)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var lessonContent: some View {
        VStack {
            if let lesson = lesson {
                lessonTitle
                //                playPauseSection(audioName: "lesson_audio_name")
                numbersSection(lesson)
                alphabetsSection(lesson)
                basicIntroductionSection(lesson)
            } else {
                Text("Loading lesson...")
                    .font(.title)
                    .padding()
                
                
            }
        }
        .onAppear {
            loadLessonData()
        }
        .onChange(of: scrollOffset) { _, newValue in
            let contentHeight = UIScreen.main.bounds.height * 2
            let isNearBottom = newValue > contentHeight * 0.9
            showButton = isNearBottom
        }
        .background(GeometryReader { geometry in
            Color.clear
                .onAppear {
                    scrollOffset = geometry.frame(in: .global).minY
                }
                .onChange(of: geometry.frame(in: .global)) { _, newValue in
                    scrollOffset = newValue.minY
                }
            Spacer()
        })
        
        
    }
    
    
    private var lessonTitle: some View {
        Text("Numbers, Alphabets and Basic Phrases")
            .font(.largeTitle)
            .bold()
            .padding([.top, .horizontal, .bottom])
    }
    
    private func playPauseSection(audioName: String) -> some View {
        VStack(spacing: 16) {
            // Play/Pause Button
            playPauseButton(audioName: audioName)
            
            // Audio Slider
            audioSlider
            
            // Time Labels
            timeLabels
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 3)
        )
        .padding(.horizontal)
    }
    
    
    private func playPauseButton(audioName: String) -> some View {
        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
            .font(.system(size: 60))
            .foregroundColor(.green)
            .onTapGesture {
                togglePlayPause(for: audioName)
            }
    }
    
    private var audioSlider: some View {
        Slider(value: Binding(get: { currentTime }, set: { newValue in
            seekAudio(to: newValue)
        }), in: 0...totalTime)
        .accentColor(.green)
    }
    
    private var timeLabels: some View {
        HStack {
            Text(timeString(time: currentTime))
                .font(.caption)
                .foregroundColor(.black)
            Spacer()
            Text(timeString(time: totalTime))
                .font(.caption)
                .foregroundColor(.black)
        }
    }
    
    private func togglePlayPause(for audioName: String) {
        isPlaying.toggle()
        if isPlaying {
            AudioManager.loadAudio(named: audioName)  // Load the audio for the passed name
            AudioManager.playAudio()
            startTimer()
        } else {
            AudioManager.pauseAudio()
            stopTimer()
        }
    }
    
    private func startTimer() {
        totalTime = AudioManager.getAudioDuration()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if isPlaying {
                currentTime = AudioManager.getCurrentTime()
                if currentTime >= totalTime {
                    stopTimer()
                    isPlaying = false
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func seekAudio(to time: TimeInterval) {
        AudioManager.seekAudio(to: time)
        currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func loadLessonData() {
        if let data = LessonLoader.loadLessons() {
            self.lesson = data.lessons["lesson_1"]
        }
    }
    
    private func numbersSection(_ lesson: Lesson) -> some View {
        VStack {
            // Play/Pause Section with Box and Shadow (only at the top)
            playPauseSection(audioName: "1-20")
            Text("Numbers")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
            
            
            // Safely unwrap the numbers dictionary once at the top
            if let numbers = lesson.sections.numbers {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(numbers.keys.sorted {
                        Int($0) ?? 0 < Int($1) ?? 0
                    }, id: \.self) { key in
                        VStack {
                            Text(key)
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                            Text(numbers[key] ?? "")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(radius: 5)
                                )
                        }
                    }
                    .padding([.leading, .trailing])
                }
            }
        }
    }
    
    private func alphabetsSection(_ lesson: Lesson) -> some View {
        VStack {
            // Play/Pause Section with Box and Shadow (only at the top)
            playPauseSection(audioName: "alphabets")
            Text("Alphabets")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(lesson.sections.alphabets ?? [], id: \.self) { letter in
                    Text(letter)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(radius: 5)
                        )
                }
            }
            .padding([.leading, .trailing])
        }
    }
    
    
    private func basicIntroductionSection(_ lesson: Lesson) -> some View {
        VStack {
            Text("Basic Introduction")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 50) {
                ForEach(lesson.sections.basic_introduction.content, id: \.id) { category in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(category.category)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                        
                        ForEach(category.phrases, id: \.self) { phrase in
                            Text(phrase)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding(.leading, 5)
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.green.opacity(0.3), Color.white]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: .black.opacity(0.1), radius: 6, x: 2, y: 4)
                    )
                }
            }
            .padding(.top, 20)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.white.opacity(0.9)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 6)
        )
        .padding(.bottom, 50)
    }
    
    private var floatingButton: some View {
        VStack {
            Spacer()
            
            Button(action: {
                withAnimation {
                    currentView = .quiz // Change the view to the quiz
                    showCongrats = true // Show the congratulations message
                }
                
                // Hide the congratulations overlay after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        showCongrats = false
                    }
                }
            }) {
                Text("Next")
                    .foregroundColor(.black)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
            }
            .padding(.top, 30)
        }
    }
    
    private var congratulationsOverlay: some View {
        Group {
            if showCongrats {
                VStack {
                    Spacer()
                    Text("🎉 Congratulations! 🎉")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white)
                                .shadow(radius: 10)
                        )
                    Spacer()
                }
                .background(Color.black.opacity(0.6).ignoresSafeArea())
                .transition(.scale)
            }
        }
    }
    
    
    // Preview
    struct LessonsView_Previews: PreviewProvider {
        static var previews: some View {
            let sampleLesson = Lesson(
                title: "Lesson 1: Numbers, Alphabets, Pronunciation & Basic Introduction",
                sections: Sections(
                    numbers: [
                        "1": "baako", "2": "mmienu", "3": "mmiɛnsa", "4": "ɛnan", "5": "anum",
                        "6": "nsia", "7": "nson", "8": "nwɔtwe", "9": "nkron", "10": "edu",
                        "11": "dubaako", "12": "dumienu", "13": "dumiɛnsa", "14": "dunan", "15": "dunum",
                        "16": "dunsia", "17": "dunson", "18": "dunwɔtwe", "19": "dunkron", "20": "aduonu"
                    ],
                    alphabets: [
                        "Aa", "Bb", "Dd", "Ee", "Ɛɛ", "Ff", "Gg", "Hh", "Ii", "Kk", "Ll", "Mm", "Nn", "Oo", "Ɔɔ", "Pp", "Rr", "Ss", "Tt", "Uu", "Ww", "Yy"
                    ],
                    basic_introduction: BasicIntroduction(
                        title: "Basic Introduction",
                        content: [
                            Category(category: "How to say your name", phrases: ["Yɛferɛ me ...", "Me din de ..."]),
                            Category(category: "I'm from ...", phrases: ["Me firi ..."]),
                            Category(category: "Reply to 'How are you?'", phrases: [
                                "Me ho yε, me da ase", "Me ho yε (\"My body is fine\")", "Bɔkɔɔ", "εyε", "Me ho yɛ, na wo nsoɛ?"
                            ]),
                            Category(category: "How do you say ... in Twi?", phrases: ["Sɛn na wɔka ... wɔ Twi kasa mu?"]),
                            Category(category: "Yes", phrases: ["Aane"]),
                            Category(category: "No", phrases: ["Daabi"]),
                            Category(category: "Maybe", phrases: ["Ebia"]),
                            Category(category: "I don’t know", phrases: ["Mennim"])
                        ]
                    )
                )
            )
            
            return LessonsView(theLesson: sampleLesson, currentView: .constant(.lessons))
        }
    }
}


//    # Preview(body: <#T##() -> any View#>)
//    struct LessonsView_Previews: PreviewProvider {
//        static var previews: some View {
//            LessonsView(theLesson: sampleLesson, currentView: .constant(.lessons))
//        }

//struct LessonsView: View {
//    @State private var lesson: Lesson?
//    @State private var isPlaying = false
//    @State private var totalTime: TimeInterval = 0.0
//    @State private var currentTime: TimeInterval = 0.0
//    @State private var timer: Timer?
//    @State private var showCongrats = false
//    @State private var navigateNext = false // To control
//    @State private var showButton = false // Add this state
//    @State private var scrollOffset: CGFloat = 0
//    
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.white, Color.green]), startPoint: .top, endPoint: .bottom)
//                .cornerRadius(12)
//                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3) // Soft shadow for elegance
//                .edgesIgnoringSafeArea(.all) // Ensures safe area is colored
//            ScrollView {
//                VStack {
//                    if let lesson = lesson {
//                        ScrollView {
//                            VStack(alignment: .leading) {
//                                // Title
//                                Text("Numbers, Alphabets and Basic Phrases")
//                                    .font(.largeTitle)
//                                    .bold()
//                                    .padding([.top, .horizontal, .bottom])
//                                
//                                // Play/Pause Section with Box and Shadow
//                                VStack(spacing: 16) {
//                                    // Play/Pause Button
//                                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.green)
//                                        .onTapGesture {
//                                            isPlaying.toggle()
//                                            if isPlaying {
//                                                print("Play button tapped")
//                                                AudioManager.loadAudio(named: "numbers0to10")
//                                                AudioManager.playAudio()
//                                                startTimer() // Start updating the slider as audio plays
//                                            } else {
//                                                print("Pause button tapped")
//                                                AudioManager.pauseAudio()
//                                                stopTimer() // Stop updating the slider when paused
//                                            }
//                                        }
//                                    
//                                    // Audio Slider
//                                    Slider(value: Binding(get: {
//                                        currentTime
//                                    }, set: { newValue in
//                                        seekAudio(to: newValue)
//                                    }), in: 0...totalTime)
//                                    .accentColor(.green)
//                                    
//                                    // Time Labels
//                                    HStack {
//                                        Text(timeString(time: currentTime))
//                                            .font(.caption)
//                                            .foregroundColor(.black)
//                                        Spacer()
//                                        Text(timeString(time: totalTime))
//                                            .font(.caption)
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                                .padding()
//                                .background(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .fill(Color.white)
//                                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 3)
//                                )
//                                .padding(.horizontal)
//                                
//                                // Numbers Grid
//                                Text("Numbers")
//                                    .font(.largeTitle)
//                                    .bold().frame(maxWidth: .infinity, alignment: .center)
//                                    .padding(.top, 20) .padding(.bottom, 10)
//                                
//                                let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] // 3 columns
//                                
//                                LazyVGrid(columns: columns, spacing: 15) {
//                                    ForEach(lesson.sections.numbers.keys.sorted {
//                                        Int($0) ?? 0 < Int($1) ?? 0
//                                    }, id: \.self) { key in
//                                        VStack {
//                                            Text(key)
//                                                .font(.title)
//                                                .bold()
//                                                .foregroundColor(.black).bold()
//                                            Text(lesson.sections.numbers[key] ?? "")
//                                                .font(.subheadline)
//                                                .foregroundColor(.black).bold()
//                                        }
//                                        .padding()
//                                        .frame(maxWidth: .infinity)
//                                        .background(
//                                            RoundedRectangle(cornerRadius: 15)
//                                                .fill(Color.white)
//                                                .shadow(radius: 5)
//                                        )
//                                    }
//                                }
//                                .padding([.leading, .trailing])
//                                
//                                // Play/Pause Section with Box and Shadow
//                                VStack(spacing: 16) {
//                                    // Play/Pause Button
//                                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.green)
//                                        .onTapGesture {
//                                            isPlaying.toggle()
//                                            if isPlaying {
//                                                print("Play button tapped")
//                                                AudioManager.loadAudio(named: "alphabets")
//                                                AudioManager.playAudio()
//                                                startTimer() // Start updating the slider as audio plays
//                                            } else {
//                                                print("Pause button tapped")
//                                                AudioManager.pauseAudio()
//                                                stopTimer() // Stop updating the slider when paused
//                                            }
//                                        }
//                                    
//                                    // Audio Slider
//                                    Slider(value: Binding(get: {
//                                        currentTime
//                                    }, set: { newValue in
//                                        seekAudio(to: newValue)
//                                    }), in: 0...totalTime)
//                                    .accentColor(.green)
//                                    
//                                    // Time Labels
//                                    HStack {
//                                        Text(timeString(time: currentTime))
//                                            .font(.caption)
//                                            .foregroundColor(.black)
//                                        Spacer()
//                                        Text(timeString(time: totalTime))
//                                            .font(.caption)
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                                .padding()
//                                .background(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .fill(Color.white)
//                                        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 3)
//                                )
//                                .padding(.horizontal).padding(.top, 200)
//                                
//                                // Alphabets Section
//                                Text("Alphabets")
//                                    .font(.largeTitle)
//                                    .bold().frame(maxWidth: .infinity, alignment: .center)
//                                    .padding(.top, 20) .padding(.bottom, 10)
//                                
//                                LazyVGrid(columns: columns, spacing: 15) {
//                                    ForEach(lesson.sections.alphabets ?? [], id: \.self) { letter in
//                                        Text(letter)
//                                            .font(.title2)
//                                            .bold()
//                                            .foregroundColor(.black)
//                                            .padding()
//                                            .frame(maxWidth: .infinity)
//                                            .background(
//                                                RoundedRectangle(cornerRadius: 15)
//                                                    .fill(Color.white)
//                                                    .shadow(radius: 5)
//                                            )
//                                    }
//                                }
//                                .padding([.leading, .trailing])
//                                
//                                // Basic Introduction Section with matching-sized category bubbles
//                                VStack {
//                                    // Title of the Section
//                                    Text("Basic Introduction")
//                                        .font(.largeTitle)
//                                        .bold()
//                                        .foregroundColor(.black)
//                                        .frame(maxWidth: .infinity, alignment: .center)
//                                        .padding(.top, 20)
//                                        .padding(.bottom, 10)
//                                    
//                                    // Wrap categories in a LazyVGrid for even layout (optional)
//                                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 50) {
//                                        ForEach(lesson.sections.basic_introduction.content, id: \.id) { category in
//                                            VStack(alignment: .leading, spacing: 10) {
//                                                // Category Title
//                                                Text(category.category)
//                                                    .font(.title2)
//                                                    .bold()
//                                                    .foregroundColor(.black)
//                                                
//                                                // Phrases
//                                                ForEach(category.phrases, id: \.self) { phrase in
//                                                    Text(phrase)
//                                                        .font(.title3)
//                                                        .foregroundColor(.black)
//                                                        .padding(.leading, 5)
//                                                }
//                                                
//                                                Spacer() // Push content to top
//                                            }
//                                            .padding()
//                                            .frame(width: 300) // FIXED size for all bubbles
//                                            .background(
//                                                RoundedRectangle(cornerRadius: 16)
//                                                    .fill(
//                                                        LinearGradient(
//                                                            gradient: Gradient(colors: [Color.green.opacity(0.3), Color.white]),
//                                                            startPoint: .topLeading,
//                                                            endPoint: .bottomTrailing
//                                                        )
//                                                    )
//                                                    .shadow(color: .black.opacity(0.1), radius: 6, x: 2, y: 4)
//                                            )
//                                        }
//                                    }
//                                    .padding(.top, 20)
//                                }
//                                .padding()
//                                .background(
//                                    RoundedRectangle(cornerRadius: 24)
//                                        .fill(
//                                            LinearGradient(
//                                                gradient: Gradient(colors: [Color.white, Color.white.opacity(0.9)]),
//                                                startPoint: .top,
//                                                endPoint: .bottom
//                                            )
//                                        )
//                                        .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 6)
//                                )
//                                .padding()
//                            }
//                            .padding(.top)
//                        }
//                        .background(GeometryReader { geometry in
//                            Color.clear.onAppear {
//                                let contentHeight = geometry.size.height
//                                let scrollViewHeight = geometry.frame(in: .global).height
//                                let contentOffset = geometry.frame(in: .global).minY
//                                
//                                // Check if scrolled to the bottom
//                                if contentHeight <= scrollViewHeight + contentOffset {
//                                    withAnimation {
//                                        showButton = true
//                                    }
//                                }
//                            }
//                        })
//                    } else {
//                        Text("Loading lesson...")
//                            .font(.title)
//                            .padding()
//                    }
//                }
//                .onAppear {
//                    if let data = LessonLoader.loadLessons() {
//                        self.lesson = data.lessons["lesson_1"]
//                        
//                    }
//                }
//                
//                .onChange(of: scrollOffset) { oldValue, newValue in
//                    let contentHeight = UIScreen.main.bounds.height * 2 // To simulate a long scroll
//                    let isNearBottom = newValue > contentHeight * 0.9
//                    showButton = isNearBottom
//                }
//                .background(GeometryReader { geometry in
//                    Color.clear
//                        .onChange(of: geometry.frame(in: .global)) { oldValue, newValue in
//                            scrollOffset = newValue.minY
//                        }
//                        .onAppear {
//                            scrollOffset = geometry.frame(in: .global).minY
//                        }
//                })
//            }
//            
//            
//            // Floating Button when showButton is true
//            if showButton {
//                VStack {
//                    Spacer()
//                    Button(action: {
//                        withAnimation {
//                            showCongrats = true
//                        }
//                        // Navigate to the next screen after 5 seconds and reset the congrats message
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                            withAnimation {
//                                showCongrats = false
//                            }
//                            navigateNext = true
//                        }
//                    }) {
//                        HStack {
//                            Text("Next")
//                                .foregroundColor(.black)
//                                .bold()
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                        }
//                        .background(Color.green)
//                        .cornerRadius(20)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(Color.white, lineWidth: 1)
//                        )
//                        .padding(.horizontal, 20)
//                    }
//                    .padding(.bottom, 20)
//                }
//            }
//            
//            // Congratulations overlay
//            if showCongrats {
//                VStack {
//                    Spacer()
//                    Text("🎉 Congratulations! 🎉")
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(.green)
//                        .padding()
//                        .background(
//                            RoundedRectangle(cornerRadius: 30)
//                                .fill(Color.white)
//                                .shadow(radius: 10)
//                        )
//                    Spacer()
//                }
//                .background(Color.black.opacity(0.6).ignoresSafeArea())
//                .transition(.scale)
//            }
//            
//            // Handle transition to quiz view when navigateNext is true
//            if navigateNext {
//                // Add your navigation logic here
//                // For example, using NavigationLink or custom view transition
//            }
//        }
//        Spacer()
//    }
//   
//
//    // Function to format the time for display
//    private func timeString(time: TimeInterval) -> String {
//        let minutes = Int(time) / 60
//        let seconds = Int(time) % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//
//    // Start a timer to update currentTime
//    private func startTimer() {
//        totalTime = AudioManager.getAudioDuration()
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            if isPlaying {
//                currentTime = AudioManager.getCurrentTime()
//                if currentTime >= totalTime {
//                    stopTimer()
//                    isPlaying = false
//                }
//            }
//        }
//    }
//
//    // Stop the timer
//    private func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    // Seek the audio to a specific time
//    private func seekAudio(to time: TimeInterval) {
//        AudioManager.seekAudio(to: time)
//        currentTime = time
//    }
//}
//
//#Preview {
//    LessonsView()
//}
//
