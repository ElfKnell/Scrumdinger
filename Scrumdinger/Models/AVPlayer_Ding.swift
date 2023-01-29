//
//  AVPlayer_Ding.swift
//  Scrumdinger
//
//  Created by Andrii Kyrychenko on 18/12/2022.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static var sharedDingPlayer: AVPlayer {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else {
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url: url)
    }
}
