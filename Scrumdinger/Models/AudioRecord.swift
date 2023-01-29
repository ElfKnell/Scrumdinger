//
//  AudioRecord.swift
//  Scrumdinger
//
//  Created by Andrii Kyrychenko on 16/01/2023.
//

import Foundation
import AVFoundation
import SwiftUI

extension SpeechRecognizer {

    static func getAudios() -> [URL] {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            var audios: [URL] = []
            
            let results = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            for result in results {
                if result.relativeString.hasSuffix(".m4a") {
                    audios.append(result)
                }
            }
            
            return audios
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
      
    static func getPlay(_ nameFile: String) -> URL {
        
        let urls = Self.getAudios()
        
        for url in urls {
            if url.relativeString == nameFile {
                return url
            }
        }
        
        
        return urls[0]
    }
}
