# Ethio Tutor 🇪🇹

**Master Amharic and Afaan Oromo with your personal AI Tutor.**

Ethio Tutor is a premium language learning application designed to help users achieve fluency in Ethiopia's most spoken languages. By leveraging the advanced capabilities of **Addis AI**, the app provides real-time speech recognition, intelligent grammar correction, and natural-sounding voice feedback.

---

## ✨ Key Features

*   **Intelligent Tutoring**: Real-time conversations with an AI that understands context, grammar, and pronunciation.
*   **Speech-to-Text (STT)**: Speak naturally in Amharic or Afaan Oromo; our AI transcribes and analyzes your speech instantly.
*   **Natural Voice Feedback**: Hear the AI respond in native-sounding voices to perfect your listening and pronunciation.
*   **Premium Ge'ez Support**: Beautifully rendered Ethiopian scripts using optimized Google Fonts for maximum readability.
*   **Personalization**: Adjust speech speed and toggle voice feedback to match your learning pace.
*   **Structured Lessons**: Specialized modules for practicing essential phrases and vocabulary.

---

## 🛠️ Technology Stack

*   **Framework**: [Flutter](https://flutter.dev) (v3.0+)
*   **Core AI**: [Addis AI APIs](https://addisassistant.com)
*   **Speech Engine**: `record` & `just_audio`
*   **Typography**: `google_fonts` (Noto Sans Ethiopic)
*   **DevOps**: GitHub Actions (CI/CD)

---

## 🚀 Getting Started

### 📦 Installation

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/wish628/ethio_tutor.git
    cd ethio_tutor
    ```

2.  **Synchronize Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Configure API Credentials**:
    -   Obtain your API Key from [Addis Assistant](https://addisassistant.com).
    -   Create a `.env` file in the root directory:
        ```env
        ADDIS_AI_API_KEY=your_key_here
        BASE_URL=https://api.addisassistant.com/api/v1
        ```

### 📱 Building the App

We recommend using our **GitHub Actions** pipeline to build the APK without needing a local Flutter installation:

1.  Push your changes to GitHub.
2.  Go to the **Actions** tab.
3.  Select the **"Build APK with Secrets"** workflow.
4.  Download the resulting artifact.

For detailed instructions, see our [GitHub Build Guide](https://github.com/wish628/ethio_tutor/blob/main/github_build_guide.md).

---

## 🔒 Security & Best Practices

-   **Privacy**: Audio recordings are processed securely via Addis AI and are not stored permanently on our servers.
-   **Credentials**: Never commit your `.env` file. We include a `.gitignore` and pre-commit hooks to safeguard your API keys.

---

## 🤝 Contributing

We welcome contributions from the community! Whether you're fixing bugs, adding new languages, or improving the UI, your help makes Ethio Tutor better for everyone.

---

## 📄 License

This project is specialized for educational purposes. All rights reserved.

---

*Powered by [Addis AI](https://addisassistant.com)*# APK build ready
