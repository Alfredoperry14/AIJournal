//
//  ContentView.swift
//  AIJournal
//
//  Created by Alfredo Perry on 2/3/25.
//
import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var userInput = ""
    @State private var showingHistory = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.messages) { message in
                                MessageView(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding()
                        .onChange(of: viewModel.messages.count) { _ in
                            if let lastMessage = viewModel.messages.last {
                                withAnimation {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                HStack {
                    TextField("Type a message...", text: $userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(viewModel.messages.last?.isUser == false && viewModel.messages.last?.text.isEmpty == true)
                    
                    Button(action: {
                        if !userInput.isEmpty {
                            viewModel.sendMessage(userInput)
                            userInput = ""
                        }
                    }) {
                        Text("Send")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(userInput.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Chat")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("New Chat") {
                        viewModel.startNewChat()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("History") {
                        showingHistory = true
                    }
                }
            }
            .sheet(isPresented: $showingHistory) {
                ChatHistoryView(viewModel: viewModel, isPresented: $showingHistory)
            }
        }
    }
}
