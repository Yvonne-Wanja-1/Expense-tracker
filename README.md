# Flutter Expense Tracker

A simple mobile application built with Flutter to track personal expenses. Allows users to add, view, and delete expenses categorized by type.

## Features

*   Add new expenses with title, amount, date, and category.
*   View a list of all recorded expenses.
*   Delete expenses with an "Undo" option via a SnackBar.
*   Display a summary count of expenses per category using icons.
*   Responsive layout adapting to portrait and landscape orientations (or different screen widths).
*   Uses Material 3 design principles.
*   Modal bottom sheet for adding new expenses.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   Flutter SDK: https://flutter.dev/docs/get-started/install
*   A code editor like VS Code or Android Studio
*   An emulator or physical device to run the app

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    ```
    *(Replace `<your-repository-url>` with the actual URL of your GitHub repository)*

2.  **Navigate to the project directory:**
    ```bash
    cd tracker
    ```
    *(Or replace `tracker` with your actual project folder name if different)*

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

## Technologies Used

*   **Flutter:** UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
*   **Dart:** Programming language used by Flutter.
*   **`intl` package:** For date formatting.
*   **Material 3:** Design system implementation.

## How to Use

1.  Launch the app.
2.  View existing expenses on the main screen.
3.  See a summary of expense counts per category above the list.
4.  Tap the '+' icon in the AppBar to open the modal for adding a new expense.
5.  Fill in the title, amount, select a date, and choose a category. Tap 'Save Expense'.
6.  To delete an expense, tap the dismiss icon (or implement swipe-to-delete if you add it later).
7.  An 'UNDO' option will appear briefly in a SnackBar after deletion.


