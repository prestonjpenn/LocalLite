# 🗺️ Local Lite

**Local Lite** is a map-based mobile app that uses AI algorithms to discover and showcase small businesses in the user’s vicinity.  
Its mission is to **“make the invisible visible”** — empowering local and remote communities where many independent vendors (like roadside farm stands, food trucks, or mom-and-pop restaurants) may not have a formal presence online.

---

## 🌍 Overview

Our system leverages the **Google Cloud Suite** to automatically identify nearby small businesses and present them in an **interactive, user-friendly map interface**.  

- **Frontend:** Built with **Flutter**, ensuring cross-platform support on both Android and iOS.  
- **Backend:** Powered by **Python FastAPI**, enabling real-time, location-aware business discovery.  
- **Map Integration:** Uses Google Maps API (mobile) and Flutter Map (web) for a consistent experience across devices.  

---

## 🚀 Features

- Discover small and independent businesses around your current location.
- Interactive map-based UI built with Flutter.
- Real-time data updates from our FastAPI backend.
- AI-enhanced discovery for unlisted or low-profile local businesses.
- Cross-platform support (Android, iOS, Web).

---

## ⚙️ Installation and Setup

### 1. Prerequisites
Before running the app, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- Android Studio or VS Code with Flutter extensions  
- (Optional) Xcode if running on iOS  
- A valid **Google Maps API key** (for Android & iOS)

---

### 2. Clone the Repository

```bash
git clone https://github.com/prestonjpenn/LocalLite.git
cd LocalLite
```

---

### 3. Configure Environment Variables

Your API keys are stored securely in a `.env` file that is **not committed** to GitHub.

Create a `.env` file in the root of the project:
```bash
touch .env
```

Inside `.env`, add your API key:
```
GOOGLE_MAPS_API_KEY=your_api_key_here
```

> ⚠️ Do **not** commit your `.env` file. It should already be excluded via `.gitignore`.

---

### 4. Install Dependencies

```bash
flutter pub get
```

---

### 5. Run the App

#### 🟢 On Android (Physical Device or Emulator)
1. Connect your device or start an Android emulator.  
2. Run:
   ```bash
   flutter run
   ```

#### 🍎 On iOS (Mac or Physical iPhone)
1. Open the project in Xcode and configure signing.
2. Run:
   ```bash
   flutter run
   ```

#### 💻 On Web (Development Preview)
Local Lite uses **Flutter Map** when running on web to keep API keys private.
```bash
flutter run -d chrome
```

---

## 🧭 Usage

- On launch, the app requests location permission.  
- Once granted, the map centers on your current location.  
- Nearby small businesses are displayed as markers on the map.  
- Tap a marker to view business details like name, category, and description.  
- Use the search bar to filter or locate other businesses nearby.

---

## 🧩 Project Structure

```
lib/
├── main.dart           # App entry point
├── screens/
│   └── home_screen.dart
├── widgets/
│   └── map_view.dart
├── services/
│   └── location_service.dart
│   └── api_service.dart
.env                    # Contains private keys (excluded from Git)
pubspec.yaml            # Project dependencies and assets
```

---

## 🛠️ Tech Stack

| Layer        | Technology              | Purpose |
|---------------|-------------------------|----------|
| Frontend      | Flutter (Dart)          | Cross-platform UI |
| Backend       | Python FastAPI          | Real-time API handling |
| Maps          | Google Maps API / Flutter Map | Geolocation & visualization |
| Cloud         | Google Cloud Platform   | Hosting & data processing |
| Environment   | flutter_dotenv          | Secure key management |

---

## 👥 Contributors

- **Preston Penn** — Flutter Development & System Integration  

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 💡 Future Improvements

- Add user-generated business submissions.
- Implement reviews and rating systems.
- Introduce offline map caching.
- Expand AI detection for unlisted business entities.

---

> _Local Lite — Making the Invisible Visible._
