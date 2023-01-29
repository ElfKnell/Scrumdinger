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
    
    @State private var isPlay = false
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        HStack {
            VStack {
                Button {
                    if !isPlay {
                        audioPlayer?.play()
                        isPlay.toggle()
                    } else {
                        audioPlayer?.pause()
                        isPlay.toggle()
                    }
                } label: {
                    Label(isPlay ? "Pause" : "Play", systemImage: isPlay ? "pause.circle.fill" : "play.circle.fill")
                        .frame(width: 20, height: 20)
                }
                
                Divider()
                
                Button {
                    audioPlayer?.stop()
                    isPlay = false
                } label: {
                    Label("Stop", systemImage: "stop.circle.fill")
                        .frame(width: 20, height: 20)
                }
            }
            .frame(width: 25)
            .padding(.horizontal)
            
            
            Divider()
            
            Text(audio.relativeString)
                .padding()
        }
        .frame(height: 45)
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
