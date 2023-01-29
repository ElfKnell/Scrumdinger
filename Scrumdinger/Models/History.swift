//
//  History.swift
//  Scrumdinger
//
//  Created by Andrii Kyrychenko on 25/12/2022.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var lengthInMinutes: Int
    var transcript: String?
    var fileName: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], lengthInMinutes: Int = 5, transcript: String? = nil, fileName: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
        self.fileName = fileName
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
    
    var dateFormat1970: String {
        let time = date.timeIntervalSince1970
         
        let times = String(time).components(separatedBy: ".")
        
        return times[0]
    }
}
