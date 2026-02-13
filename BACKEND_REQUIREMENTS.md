# AfroLingo Backend Requirements Document

## 1. Overview
This document outlines the backend architecture and service requirements for AfroLingo, a Ghanaian language learning application. The backend must support high-concurrency audio processing, user progress tracking, and dynamic content delivery.

---

## 2. Authentication & User Management
The system requires a secure and flexible authentication layer.

### 2.1. Authentication Methods
- **OAuth2 Integration**: Support for Google and Apple Sign-In.
- **Email/Password**: Standard registration with email verification and password recovery.
- **Session Management**: JWT-based authentication for stateless API interactions or Firebase Auth tokens.

### 2.2. User Profile Management
- **Profile Data**: Storage for first name, last name, phone number, email, and profile avatar URL.
- **Preferences**: Target language (Twi, Ga, Ewe, Fante), proficiency level, and notification settings.
- **Account State**: Tracking account creation date and last login.

---

## 3. Core AI Services (STT/LLM/TTS Pipeline)
This is the application's Unique Selling Proposition (USP). The backend must orchestrate a low-latency audio-to-audio pipeline.

### 3.1. Speech-to-Text (STT)
- **Requirement**: Convert user audio (accented Ghanaian English or native languages) into text.
- **Latency**: Sub-500ms response time.
- **Accuracy**: Must be optimized for West African accents and tonal languages.

### 3.2. Large Language Model (LLM)
- **Requirement**: Process transcribed text and generate contextually relevant responses in the target language.
- **Capabilities**: 
    - Real-time conversation logic.
    - Grammar and pronunciation correction (Correction Mode).
    - Translation services (Literal vs. Contextual).

### 3.3. Text-to-Speech (TTS)
- **Requirement**: Convert AI-generated text into natural-sounding audio.
- **Requirement**: Use voices that sound native to Ghana (avoiding generic robotic tones).
- **Streaming**: Support for audio streaming to reduce "Time to First Byte" (TTFB).

---

## 4. Content Management System (CMS)
The backend must serve dynamic learning content to the frontend.

### 4.1. Language Schema
- Support for multiple Ghanaian languages (Twi, Ga, Ewe, Fante, etc.).
- Metadata for each language (flag, region, difficulty).

### 4.2. Scenarios & Lessons
- **Hierarchy**: Sections (e.g., GREETINGS, TRAVEL) -> Scenarios (e.g., Coffee Shop, Airport).
- **Metadata**: Title, Description, Estimated Duration, Background Image URL.
- **Dialogue Data**: Prompt sequences for specific scenarios to guide the user.

---

## 5. Gamification & Progress Tracking
To drive user retention, the backend must manage all gamification logic.

### 5.1. Streak Management
- **Daily Tracker**: Logic to increment, reset, or freeze streaks based on daily activity (UTC-based).
- **Historical Data**: Calendar-view data for user progress visualization.

### 5.2. XP & Leveling System
- **Event-Based XP**: Points for completing scenarios, practicing audio, or daily logins.
- **Level Calculation**: Dynamic calculation of user levels based on total XP.

### 5.3. Leaderboards
- Global and friend-based leaderboards.
- Weekly/Monthly reset cycles.

---

## 6. Infrastructure & API Requirements

### 6.1. Database (NoSQL vs. SQL)
- **Firebase Firestore/Supabase**: Recommended for real-time synchronization and ease of integration with Flutter.
- **Scalability**: Must handle concurrent audio streams and frequent status updates.

### 6.2. Media Storage
- Secure storage for user avatars and AI-generated audio clips (Bucket storage like GCS or S3).

### 6.3. API Specifications
- **RESTful API or GraphQL**: For content fetching and profile management.
- **WebSockets/gRPC**: For real-time, low-latency audio communication in the "Padiman AI" interface.

---

## 7. Security & Compliance
- **Data Encryption**: TLS for data in transit and AES-256 for data at rest.
- **GDPR/CCPA Compliance**: Support for account deletion and data export requests.
- **Rate Limiting**: Protection against API abuse, especially for AI-related endpoints.
