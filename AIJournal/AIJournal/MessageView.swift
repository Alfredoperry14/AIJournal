//
//  MessageView.swift
//  AIJournal
//
//  Created by Alfredo Perry on 2/3/25.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            Text(message.text)
                .padding()
                .background(message.isUser ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(message.isUser ? .white : .black)
            if !message.isUser { Spacer() }
        }
    }
}
/*
#Preview {
    MessageView()
}
*/
