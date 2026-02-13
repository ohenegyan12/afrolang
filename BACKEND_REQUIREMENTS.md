```markdown
# AfroLingo Backend Requirements Document

## 1. Authentication (Auth)
- **OAuth2 Integration**: Support for Google and Apple Sign-In.
- **Email/Password**: Standard registration with email verification and password recovery.
- **Session Management**: JWT-based authentication or Firebase Auth tokens for stateless API interactions.

## 2. Learning Scenarios (Scenarios)
- **Content Hierarchy**: Sections (e.g., GREETINGS) -> Scenarios (e.g., Coffee Shop).
- **Metadata**: Title, Description, Estimated Duration, and Background Image URL.
- **Dialogue Data**: Pre-defined prompt sequences to guide user interactions.
- **Language Support**: Multi-language schema (Twi, Ga, Ewe, Fante) with difficulty metadata.

## 3. User-Generated Content (Creating Own Scenarios)
- **Custom Scenario Creation**: API to allow users to define custom scenario titles and initial AI prompts.
- **Persistence**: Storage of user-defined scenarios in a private user collection.
- **Validation**: Content filtering for custom prompts to ensure safety and relevance.

## 4. User Settings & Preferences (Updating Settings)
- **Profile Management**: Update first name, last name, phone number, and avatar URL.
- **Learning Preferences**: Update target language, proficiency level, and notification toggles.
- **Account State**: Manage account deletion and data export requests (GDPR/CCPA).

## 5. Engagement & Retention (Streaks)
- **Daily Tracker**: Logic to increment, reset, or freeze streaks based on daily activity (UTC-based).
- **Historical Data**: Storage of activity timestamps for calendar-view visualization.
- **Streak Protection**: Support for "Streak Freeze" items or grace periods.

## 6. User Progress & Gamification (Progresses)
- **XP System**: Event-based points for completing scenarios, audio practice, or daily logins.
- **Leveling**: Dynamic calculation of user levels based on cumulative XP thresholds.
- **Leaderboards**: Global and friend-based ranking systems with weekly/monthly reset cycles.

## 7. Core Infrastructure & AI Pipeline (All)
- **AI Pipeline**: Orchestration of STT (Speech-to-Text), LLM (Contextual Logic), and TTS (Text-to-Speech) with sub-500ms latency.
- **Database**: Firebase Firestore or Supabase for real-time synchronization.
- **Media Storage**: Secure bucket storage (GCS/S3) for user avatars and AI audio clips.
- **Security**: TLS encryption in transit, AES-256 at rest, and API rate limiting.
```
