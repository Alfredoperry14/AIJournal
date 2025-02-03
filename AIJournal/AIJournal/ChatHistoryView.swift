//
//  ChatHistoryView.swift
//  AIJournal
//
//  Created by Alfredo Perry on 2/3/25.
//

import SwiftUI

struct ChatHistoryView: View {
    @ObservedObject var viewModel: ChatViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.chatHistory.keys.sorted()), id: \.self) { chatId in
                    Button {
                        viewModel.loadChat(id: chatId)
                        isPresented = false
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Chat \(chatId.prefix(8))")
                                .font(.headline)
                            if let firstMessage = viewModel.chatHistory[chatId]?.first {
                                Text(firstMessage.text)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Chat History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
/*
#Preview {
    ChatHistoryView()
}
*/
