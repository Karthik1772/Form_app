# Formify App

## Description

**Formify** is a Flutter-based mobile application built with **Clean Architecture** principles. It provides a structured and scalable foundation for building forms and handling user input efficiently. The app includes custom UI components such as buttons, snackbars, dropdowns, and text fields. Additionally, it features generated routes and a custom app theme for a consistent user experience.

Formify is designed to help developers implement form-based applications efficiently while maintaining clean and maintainable code.

## Features

- **Clean Architecture**: Organized code structure with separation of concerns.
- **Custom Widgets**: Reusable UI components for consistency.
  - `CustomButton`
  - `CustomSnackbar`
  - `CustomDropdown`
  - `CustomTextField`
- **Generated Routes**: Simplified navigation management.
- **Custom App Themes**: Ensures a consistent look and feel.
- **Scalability**: Built to support future enhancements and additional features.

## Installation

### Prerequisites

Before running the app, ensure you have **Flutter** and **Dart** installed. Follow the official installation guide: [Flutter Installation](https://flutter.dev/docs/get-started/install).

### Steps to Run the App

1. **Clone the repository**:
   ```sh
   git clone https://github.com/your-username/formify.git
   ```

2. **Navigate to the project directory**:
   ```sh
   cd formify
   ```

3. **Install dependencies**:
   ```sh
   flutter pub get
   ```

4. **Run the app**:
   ```sh
   flutter run
   ```

## Project Structure

The Formify app follows a modular structure to keep the code clean and manageable.

```
lib/
│── main.dart          # Entry point of the app
│
├── core/
│   ├── theme/        # Custom themes
│   ├── widgets/      # Reusable UI components
|   ├── routes/       # Generated routes
│
├── features/
│   │   ├── final_page/                      # Final page
│   │   ├── sheet_pages/                     # Form input sections
│   │   │   ├── Consumer_Choices/
│   │   │   ├── Demographic_Information/
│   │   │   ├── Energy_Consumption/
│   │   │   ├── Environmentally_Awareness/
│   │   │   ├── Food_Consumption/
│   │   │   ├── Miscellaneous_details/
│   │   │   ├── Occupation_details/
│   │   │   ├── waste_managment/
│   │   ├── splash_screen/                   # Initial app loading screen
```
## Technologies Used

- **Flutter**: Framework for cross-platform mobile development.
- **Dart**: The programming language used to build the app.
- **Provider / Riverpod / Bloc (if used)**: State management for handling app logic.
- **Flutter Widgets**: Custom components for UI consistency.

## License

This project is open-source and licensed under the [MIT License](LICENSE).

## Contributing

We welcome contributions! Feel free to fork the repository, make improvements, and submit a pull request.

## Acknowledgements

- **Flutter**: For providing a robust framework for app development.
- **Community Contributors**: For continuous improvements and suggestions.

---

