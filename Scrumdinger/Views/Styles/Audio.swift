//
//  Audio.swift
//  Scrumdinger
//
//  Created by Andrii Kyrychenko on 22/01/2023.
//

import SwiftUI
import AVFoundation

struct Audio: View {
    var audio: URL
    
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        HStack {
            Button {
                audioPlayer?.play()
            } label: {
                Label("Play", systemImage: "play.circle.fill")
            }
            
            Text(audio.relativeString)
            
            Button {
                audioPlayer?.stop()
            } label: {
                Label("Stop", systemImage: "stop.circle.fill")
            }
        }
        .onAppear {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audio)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct Audio_Previews: PreviewProvider {
    static var urls = SpeechRecognizer.getAudios()
    
    static var previews: some View {
        Audio(audio: urls[0])
    }
}
