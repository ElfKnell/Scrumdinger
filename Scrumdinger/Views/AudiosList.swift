//
//  AudiosList.swift
//  Scrumdinger
//
//  Created by Andrii Kyrychenko on 21/01/2023.
//

import SwiftUI
import AVFoundation

struct AudiosList: View {
    @State private var audios = SpeechRecognizer.getAudios()
    
    var body: some View {
        ScrollView {
            
            ForEach (audios, id: \.self) { audio in
                Divider()
                
                Audio(audio: audio)
                
                Divider()
            }
        }
    }
}

struct AudiosList_Previews: PreviewProvider {
    static var previews: some View {
        AudiosList()
    }
}
