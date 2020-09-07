//
//  Alarm.swift
//  Alarms
//
//  Created by Vladimir Inozemtsev on 29.08.2020.
//

import Foundation

final class Alarm : Codable {
    
    init(name: String? = nil, alarmDate: Date, shouldNotify: Bool) {
        self.id = UUID()
        self.name = name
        self.alarmDate = alarmDate
        self.shouldNotify = shouldNotify
    }
    
    let id: UUID
    var name: String?
    var alarmDate: Date
    var shouldNotify: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, alarmDate, shouldNotify
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        alarmDate = try container.decode(Date.self, forKey: .alarmDate)
        shouldNotify = try container.decode(Bool.self, forKey: .shouldNotify)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(alarmDate, forKey: .alarmDate)
        try container.encode(shouldNotify, forKey: .shouldNotify)
    }
}
