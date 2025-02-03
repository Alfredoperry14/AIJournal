# AI Journal - Chatbot App

## Overview
AI Journal is an iOS-based chatbot application that allows users to share their thoughts and receive AI-generated advice. The app ensures that each new session starts with a fresh chat while preserving chat history. This project serves as a foundational example of building a chatbot experience with SwiftUI and Combine.

## Key Features
- **Real-time AI Conversations**: Users can chat with an AI assistant that provides thoughtful responses.
- **Session Management**: Every new app launch starts a fresh conversation while maintaining past chat history.
- **SwiftUI & Combine Integration**: Utilizes SwiftUI for the user interface and Combine for handling data flow.
- **State Management**: Implements `@Published` properties in `ChatViewModel` for reactive updates.
- **Chat History Storage**: Ensures previous conversations are accessible for later reference.

## Technical Implementation
### 1. **ChatViewModel.swift**
- Manages chat history and messages.
- Generates a new `chatId` at app launch to ensure fresh sessions.
- Uses `@Published var messages: [Message]` to manage active chat messages.

### 2. **ChatView.swift**
- Displays chat messages using a SwiftUI list.
- Supports real-time message updates and user input.

### 3. **ChatHistoryView.swift**
- Stores past conversations and allows users to revisit them.
- Retrieves previous chat sessions when needed.

### 4. **AIJournalApp.swift**
- Handles app launch and ensures `ChatViewModel` initializes correctly.

## Prompt Engineering
Effective prompt engineering plays a crucial role in enhancing the chatbot’s performance. Below are some prompt strategies that were beneficial:

### **Types of Prompts for a Chatbot Application**
1. **Contextual Memory Prompts**
   - _"The user is feeling down and needs uplifting advice. Respond with empathy and encouragement."_
   - _"The user is reflecting on their day. Ask open-ended questions to guide introspection."_

2. **Instruction-Based Prompts**
   - _"Provide a concise yet insightful response to the user’s concern."_
   - _"If the issue appears serious, suggest seeking professional help."_

3. **Conversational Flow Prompts**
   - _"Act as an understanding listener. Respond with a mix of validation and subtle guidance."_
   - _"Avoid giving medical or financial advice; instead, suggest general best practices."_

## Prompts for Non-Programmers to Build This Project
If you have zero programming knowledge and want ChatGPT to guide you through the development of this chatbot app, you can use the following types of prompts:

1. **Project Planning & Setup**
   - _"How can I create a simple AI chatbot app for iOS using SwiftUI?"_
   - _"What tools and frameworks do I need to build an AI-powered chat application?"_

2. **Code Generation**
   - _"Generate SwiftUI code for a chat interface that allows users to send and receive messages."_
   - _"Write a Swift class to manage chat history and save previous conversations."_

3. **Debugging & Fixes**
   - _"Why is my SwiftUI chat app not displaying new messages correctly?"_
   - _"Help me fix an issue where old chat messages are overriding new ones in SwiftUI."_

4. **App Deployment & Testing**
   - _"How do I test my SwiftUI app before publishing it on the App Store?"_
   - _"Guide me through deploying an iOS app with AI-powered responses."_

By using structured prompts like these, even someone with no programming experience can systematically build and refine this project with the help of ChatGPT.


## Conclusion
- This was my final project for the Vanderbilt Prompt Engineering Course on Coursera. Everything in this README besides the conclusion was written by AI. I had a lot of fun taking the course and it was really insightful learning how many prompt patterns there are. 
- [AI Journal Wrapper](https://youtube.com/shorts/OKw7t9EgkH0?feature=share) (YouTube Short)
