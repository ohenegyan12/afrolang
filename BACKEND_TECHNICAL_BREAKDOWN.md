# AfroLingo Backend: Technical Breakdown

This document provides a detailed technical breakdown of the AfroLingo backend services, including architecture, data models, and API specifications.

---

## 1. System Architecture
We recommend a **Serverless/Cloud Function** architecture for scalability and ease of integration with Flutter.

- **Primary Provider**: Firebase or Supabase.
- **Computation**: Cloud Functions (Node.js/TypeScript or Python).
- **Database**: Firestore (NoSQL) or PostgreSQL (Relational - Supabase).
- **Communication**: REST for general data; WebSockets or Realtime SDK for AI Chat.

---

## 2. Data Model Breakdown

### `users` (Collection/Table)
- `uid`: String (Primary Key)
- `email`: String
- `displayName`: String
- `photoURL`: String
- `phoneNumber`: String
- `targetLanguage`: String (e.g., 'twi', 'ga')
- `xp`: Integer
- `level`: Integer
- `streakCount`: Integer
- `lastActiveDate`: Timestamp
- `createdAt`: Timestamp

### `sections` & `scenarios`
- `sectionId`: String
- `title`: String (e.g., "GREETINGS")
- `scenarios`: List<ScenarioObject>
    - `id`: String
    - `title`: String
    - `description`: String
    - `imageUrl`: String
    - `duration`: String
    - `difficulty`: Enum (Beginner, Intermediate, Advanced)

### `user_progress` (Sub-collection under User)
- `scenarioId`: String
- `isCompleted`: Boolean
- `score`: Integer
- `completedAt`: Timestamp
- `practiceHistory`: List<PracticeSession>

---

## 3. API & Service Endpoints

### 3.1. Authentication Service
- `POST /auth/register`: Initialize user record after Firebase Auth success.
- `GET /user/profile`: Fetch current user's stats and preferences.
- `PATCH /user/profile`: Update language choice or avatar.

### 3.2. Learning Content Service
- `GET /content/sections`: Retrieve all available learning categories.
- `GET /content/scenarios/{sectionId}`: Retrieve scenarios for a specific section.
- `GET /content/scenario/{scenarioId}`: Detail view of a scenario (dialogue prompts, audio samples).

### 3.3. AI Interaction Service (The "Padiman" Engine)
- **POST /ai/chat/text**: Send user text, receive AI text + audio URL.
- **POST /ai/chat/audio**: Upload user `.m4a`/`.wav`, receive transcription, AI response text, and generated audio.
- **POST /ai/correct**: Analyze a specific user utterance for grammar/pronunciation feedback.

### 3.4. Progress & Gamification Service
- `POST /progress/complete-scenario`: Record completion and update XP.
- `GET /progress/streak`: Calculate and return current streak status and calendar history.
- `GET /leaderboard`: Fetch top users (Global or Language-specific).

---

## 4. The AI Audio Pipeline (Step-by-Step)
For the low-latency "Padiman AI" experience:

1.  **Ingestion**: Flutter app streams audio to a Cloud Function or WebSocket.
2.  **STT (Whisper)**: Audio is converted to text.
3.  **Context Injection**: The text + User's Profile (language) + Scenario Context is sent to the LLM.
4.  **LLM (GPT-4o)**: Generates a response and a "hidden" correction if the user made a mistake.
5.  **TTS (OpenAI/ElevenLabs)**: The text response is converted back to audio.
6.  **Response**: Backend returns a JSON object containing:
    - `aiText`: The spoken response.
    - `audioUrl`: Link to pre-signed audio file.
    - `translation`: The English translation.
    - `feedback`: (Optional) Grammar tips.

---

## 5. Implementation Phases

### Phase 1: Infrastructure & Auth
- Set up Firebase/Supabase environment.
- Implement User Schema and Auth triggers.
- Basic CRUD for User Profiles.

### Phase 2: Static Content Delivery
- Build the CMS for Sections and Scenarios.
- Implement `GET` endpoints for the home screen and scenario list.

### Phase 3: AI MVP (Text-based)
- Orchestrate LLM with prompt engineering for Twi/Ga/Ewe.
- Implement text-to-text chat with translations.

### Phase 4: Audio Integration (The Hook)
- Integrate Whisper (STT) and TTS.
- Implement audio streaming or fast file-upload processing.
- Build the "Correction Mode" logic.

### Phase 5: Polish & Scale
- Add Leaderboards and Streak calculation logic.
- Implement caching for frequent requests.
- Set up monitoring and logging for AI latency.
