## User Stories

1. Managing To-Do Lists

- As a user, I want to see a list of all my tasks so I know what I need to work on.
- As a user, I want to be able to add new tasks with titles and descriptions so I can log new tasks.
- As a user, I want to be able to edit existing tasks so I can update task details as they change.
- As a user, I want to be able to delete completed or unnecessary tasks to keep my to-do list neat.
- As a user, I want tasks to be marked as complete so I know what work has been completed.

2. User Validation and Feedback

- As a user, I want to be notified (snackbar) if there is an error when adding, updating, or deleting a task so I know what went wrong.
- As a user, I want to get a success message when I successfully add, update, or delete a task so I know my actions were successful.

3. Error Handling

- As a user, I want to be notified (red snackbar) if the app fails to load my to-do list so I know there is a problem.
- As a user, I want to be given the option to retry if a data load fails so that I can fix temporary issues, such as a lost internet connection.
- As a user, I want the app to handle errors in a user-friendly way without causing a crash so that the app experience remains pleasant.

4. User Interface

- As a user, I want to use a simple and easy-to-use app interface so that I can quickly understand how to manage my to-do list.
- As a user, I want to see a loading indicator as the app processes data so that I know the app is working.
- As a user, I want input validation that ensures I don't submit an empty form so that the tasks I create have complete information.

## Screenshot
![image](https://github.com/user-attachments/assets/d0da7562-31ea-43eb-9ed9-b6af8dbdd38a)

# Todo App Firebase

## Project Overview
A Flutter todo application using Firebase for backend and state management.

## Prerequisites
- Flutter SDK (latest stable version)
- Android Studio or VS Code
- Firebase account

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/markhadi/todo_app_firebase.git
cd todo_app_firebase
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Configuration
1. Create a new Firebase project in the Firebase Console
2. Enable Cloud Firestore
3. Update Firestore Rules:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

### 4. FlutterFire Setup
```bash
flutterfire configure --project=your-project-id
```
- Android Application ID: `com.example.todo_app_firebase`

### 5. Run the Application
```bash
flutter run
```
