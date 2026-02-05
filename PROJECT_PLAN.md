# Ghanaian Language Learning App - Project Plan

## 1. Project Overview
A mobile application for learning Ghanaian languages (Twi, Ga, Ewe, etc.) with a focus on conversational practice.  
**Core USP**: An AI-powered audio feature enabling real-time, human-like conversations to practice pronunciation and comprehension.  
**Gamification**: Duolingo-style streaks, quizzes, and progress tracking.

---

## 2. Document & System Structure

### Full System Architecture
The system will consist of three main components:
1.  **Mobile App (Flutter)**: The frontend interface for users (iOS & Android).
2.  **Backend (Firebase/Supabase or Custom Node/Python)**: Handles user authentication, database (progress, streaks), and API orchestration.
3.  **AI Engine (Python/External APIs)**:
    *   **STT (Speech-to-Text)**: Converts user speech to text (handling Ghanaian accents/languages).
    *   **LLM (Language Model)**: Generates context-aware responses and corrections.
    *   **TTS (Text-to-Speech)**: Converts AI responses back to natural-sounding audio.

### App Folder Structure (Flutter - `lib/`)
We will use a **Feature-First** architecture to keep the codebase scalable.

```
lib/
├── main.dart                # Entry point
├── core/                    # Shared resources
│   ├── constants/           # Colors, Strings, API keys
│   ├── theme/               # App theme (Dark/Light mode)
│   ├── services/            # Global services (Audio, API, Auth)
│   └── utils/               # Helper functions
├── features/
│   ├── auth/                # Authentication key screens & logic
│   ├── home/                # tailored Dashboard & Streak view
│   ├── learn/               # Main learning path (Levels, Modules)
│   ├── conversation/        # THE MVP CORE: Audio Chat Interface
│   │   ├── screens/         # Chat UI (Waveforms, Mic button)
│   │   ├── providers/       # State management for chat
│   │   └── services/        # WebSocket/Stream handling for audio
│   └── profile/             # User stats, settings
└── widgets/                 # Reusable UI components (Buttons, Cards)
```

---

## 3. MVP Requirements (Minimum Viable Product)
**Goal**: Launch with the "Audio Conversation" as the hook, plus basic progression.

### Core Features
1.  **Authentication**:
    *   Sign up/Login (Google, Apple, Email).
    *   Profile creation (Select target language: Twi, Ga, etc.).
2.  **Conversational AI (The USP)**:
    *   **Interface**: Clean, WhatsApp/ChatGPT-style voice mode. Large microphone button, audio visualizer/waveform.
    *   **Functionality**:
        *   User speaks -> App transcribes -> AI responds via Audio.
        *   "Correction Mode": AI gently corrects grammar/pronunciation after the exchange.
        *   *Technical Note*: Use a low-latency API (e.g., OpenAI Realtime API or a custom pipeline with Whisper + TTS).
3.  **Basic Gamification**:
    *   **Streaks**: Daily login tracker.
    *   **XP System**: Points for every conversation completed.
4.  **Simple Curriculum**:
    *   "Daily Topic" (e.g., Greetings, Market, Family).
    *   Users can ask "How do I say X?" in the target language.

### Tech Stack Recommendation
*   **Frontend**: Flutter (Dart)
*   **Backend**: Firebase (Auth, Firestore for database, Cloud Functions)
*   **AI**: OpenAI API (Whisper for STT, GPT-4o for logic, TTS) or specialized models for Ghanaian languages if available.

---

## 4. Future Updates (Roadmap)
**Phase 2: Deepening Content**
*   **Structured Lessons**: Tree-style progression (like Duolingo) for grammar and vocabulary.
*   **Writing & Reading Quizzes**: Fill-in-the-blanks, matching pairs.

**Phase 3: Community & Competition**
*   **Leaderboards**: Weekly/Monthly top learners.
*   **Social Features**: Add friends, challenge others.

**Phase 4: Advanced AI**
*   **Pronunciation Assessment**: Real-time feedback on *how* well you said a word (colored feedback: Green=Good, Red=Retry).
*   **Offline Mode**: Download lessons for offline practice.
