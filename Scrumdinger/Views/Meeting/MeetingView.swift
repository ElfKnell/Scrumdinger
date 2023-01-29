//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Andrii Kyrychenko on 11/12/2022.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @State private var isRecording = false
    
    private var name: String {
        let d =  Date.now.timeIntervalSince1970
        let dates = String(d).components(separatedBy: ".")

        return "Rec_\(dates[0])_.m4a"
    }
    
    @State private var nameFile: String = ""
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme)
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.ckipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            speechRecognizer.reset()
            speechRecognizer.transcrible()
            isRecording = true
            scrumTimer.startScrum()
            
            nameFile = name
            speechRecognizer.audioRecord(name: nameFile)
        }
        .onDisappear {
            scrumTimer.stopScrum()
            speechRecognizer.stopTranscribing()
            isRecording = false
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrum.timer.secondsElapsed / 60, transcript: speechRecognizer.transcript, fileName: nameFile)
            scrum.history.insert(newHistory, at: 0)
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
