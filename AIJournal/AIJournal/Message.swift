//
//  Message.swift
//  AIJournal
//
//  Created by Alfredo Perry on 2/3/25.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    let text: String
    let isUser: Bool
    
    // Custom initializer to generate a UUID when creating a new message
    init(id: UUID = UUID(), text: String, isUser: Bool) {
        self.id = id
        self.text = text
        self.isUser = isUser
    }
    
    // Define CodingKeys enum
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case isUser
    }
    
    // Custom decoding to allow decoding of `id`
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        isUser = try container.decode(Bool.self, forKey: .isUser)
    }
    
    // Custom encoding to encode `id`
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(isUser, forKey: .isUser)
    }
}
