# Todo List App with Flutter and Hive

This project is a Todo List application developed using Flutter and Hive as a local database. The main goal of this project is to learn and implement the Inherited Widget concept in Flutter.

## 🎯 Project Goal

The primary goal of this project is to understand and implement the Inherited Widget concept in Flutter. Inherited Widget is an important pattern in Flutter that allows efficient data passing through the widget tree, and it's the foundation for many state management solutions like Provider.

## 🚀 Features

- Add, update, and delete tasks
- Local data storage using Hive
- Attractive and user-friendly interface
- Use of Inherited Widget for app state management

## 💻 Technologies Used

- **Flutter**: Framework for UI development
- **Hive**: Lightweight and fast NoSQL database for local storage
- **Inherited Widget**: For app state management and data passing

## 🏗️ Project Structure

```
lib/
├── core/           # Constants, colors, and strings
├── data/           # Data layer (Hive)
├── models/         # Data models
└── views/          # User interfaces
    └── home/       # Main screen and components
```

## 📱 How Inherited Widget is Used in the Project

Inherited Widget is implemented in this project through `BaseWidget` which provides the application state to all child widgets. This allows:

- Easy access to app data from anywhere in the widget tree
- Automatic UI updates when data changes
- Avoiding manual data passing through constructors

## 🛠️ How to Run the Project

1. Make sure Flutter is installed on your device
2. Download the project
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## 📚 References and Resources

- [Flutter Official Website](https://flutter.dev)
- [Hive Documentation](https://docs.hivedb.dev)
- [Inherited Widgets in Flutter](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)
