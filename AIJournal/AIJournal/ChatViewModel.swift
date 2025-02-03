//
//  ChatViewModel.swift
//  AIJournal
//
//  Created by Alfredo Perry on 2/3/25.
//

import SwiftUI
import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var chatHistory: [String: [Message]] = [:]
    @Published var currentChatId: String = UUID().uuidString // Ensure new chat starts on launch
    private let apiKey = "ENTER_ANTHROPIC_API_KEY_HERE"
    private let storageKey = "savedChats"
    
    init() {
        self.currentChatId = UUID().uuidString
        loadChats()
        startNewChat()
    }
    
    func startNewChat() {
        currentChatId = UUID().uuidString
        messages = []
        objectWillChange.send()
        saveChats()
    }
    
    func loadChat(id: String) {
        currentChatId = id
        messages = chatHistory[id] ?? []
        objectWillChange.send()
    }
    
    func sendMessage(_ text: String) {
        let userMessage = Message(text: text, isUser: true)
        messages.append(userMessage)
        chatHistory[currentChatId] = messages
        saveChats()
        fetchAIResponse(for: text)
    }
    
    private func fetchAIResponse(for userInput: String) {
        guard let url = URL(string: "https://api.anthropic.com/v1/messages") else {
            print("❌ Invalid URL")
            return
        }
        
        let requestBody: [String: Any] = [
            "model": "claude-3-5-sonnet-20241022",
            "max_tokens": 500,
            "messages": [
                ["role": "user", "content": userInput]
            ],
            "system": "You are a supportive AI friend. Listen to the user's problems and provide advice. If they mention serious issues like self-harm, suggest seeking professional help."
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("❌ Failed to serialize request body: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Request Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received from API")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(AnthropicResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if let firstContentItem = decodedResponse.content.first {
                        let aiMessage = Message(text: firstContentItem.text, isUser: false)
                        self.messages.append(aiMessage)
                        self.chatHistory[self.currentChatId] = self.messages
                        self.saveChats()
                        self.objectWillChange.send()
                    }
                }
            } catch {
                print("❌ Decoding Error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📩 Raw JSON Response: \(jsonString)")
                }
            }
        }.resume()
    }
    
    private func saveChats() {
        if let encoded = try? JSONEncoder().encode(chatHistory) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func loadChats() {
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let savedChats = try? JSONDecoder().decode([String: [Message]].self, from: savedData) {
            chatHistory = savedChats
            if let firstChatId = chatHistory.keys.first {
                currentChatId = firstChatId
                messages = chatHistory[firstChatId] ?? []
            }
        }
    }
}


// MARK: - Response Model

struct AnthropicResponse: Decodable {
    struct ContentItem: Decodable {
        let type: String
        let text: String
    }
    
    let content: [ContentItem]
}
