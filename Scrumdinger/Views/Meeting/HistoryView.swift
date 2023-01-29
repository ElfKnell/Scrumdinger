//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Andrii Kyrychenko on 29/12/2022.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.bottom)
                    
                    Text("Attendees")
                        .font(.headline)
                    
                    Text(history.attendeeString)
                    
                    if let transcript = history.transcript {
                        Text("Transcript")
                            .font(.headline)
                            .padding(.top)
                        
                        Text(transcript)
                    }
                }
            }
            
            Divider()
            
            if history.fileName == nil {
                Text("The file does not exist.")
            } else {
                Audio(audio: SpeechRecognizer.getPlay(history.fileName!))
            }
            
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    
    static var history: History {
        History(attendees: [DailyScrum.Attendee(name: "Jon"), DailyScrum.Attendee(name: "Darla"), DailyScrum.Attendee(name: "Luis")], lengthInMinutes: 10, transcript: "Darla, would you like start today? Sure, yesterday I reviewed Luis' PR and met with the desing team to finalize the UI...")
    }
    
    static var previews: some View {
            HistoryView(history: history)
    }
}
