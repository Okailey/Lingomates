//
//  loadAudio.swift
//  LingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/26/25.
//
import Foundation
import AVFoundation


class AudioManager {
    static var audioPlayer: AVAudioPlayer?

    // Load audio from the bundle (only .wav files)
    static func loadAudio(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "wav") {
            print("✅ Audio URL found: \(url)")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading audio: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found: \(soundName).wav")
        }
    }

    // Play the loaded audio
    static func playAudio() {
        if let player = audioPlayer {
            if !player.isPlaying {
                player.play()
            }
        } else {
            print("AudioPlayer is nil, can't play.")
        }
    }

    // Pause the audio
    static func pauseAudio() {
        if let player = audioPlayer, player.isPlaying {
            player.pause()
        } else {
            print("Audio is already paused or not loaded.")
        }
    }

    // Stop the audio
    static func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    // Seek to a specific time in the audio
     static func seekAudio(to time: TimeInterval) {
         if let player = audioPlayer {
             player.currentTime = time
         } else {
             print("AudioPlayer is nil, can't seek.")
         }
     }

     // Get the current time of the audio
     static func getCurrentTime() -> TimeInterval {
         return audioPlayer?.currentTime ?? 0.0
     }

     // Get the total duration of the audio
     static func getAudioDuration() -> TimeInterval {
         return audioPlayer?.duration ?? 0.0
     }
}

