# Individual Assignment - Note Taking App 📒

This project is a mini note-taking app built with **Flutter** and **Firebase**. It allows users to sign up, log in, and manage their notes securely. The app implements Firebase Authentication with email and password, along with full CRUD operations for managing notes stored in Firestore.

---

## 📱 App Features

- **User Authentication**  
  - Sign up & Login using email & password via Firebase Authentication.
  - New users are automatically routed to the main interface after login.

- **Notes Management (CRUD)**
  - **Read Notes:** Fetch and display all notes from Firestore.
  - **Add Note:** Add a new note using a dialog input.
  - **Update Note:** Edit an existing note via the edit icon.
  - **Delete Note:** Remove a note using the delete icon.

---

## 📋 UI Preview

> If the note list is empty, the app displays the message:  
> `"Nothing here yet—tap ➕ to add a note."`  
> This helps guide new users to start adding notes.

---

## 🏗️ Architecture & Requirements

- **Clean Architecture:**  
  UI is separated from business logic to maintain a clean, scalable codebase.

- **State Management:**  
  Uses **Bloc/Cubit** or **Provider** (or any other state management solution).  
  ➡️ `setState()` is **NOT** allowed for this assignment.

- **UX Details:**
  - SnackBars are shown on every success or error operation.
  - Displays a loading indicator during the initial data fetch.

---

## 🔧 Tech Stack

- **Flutter**
- **Firebase Authentication**
- **Firestore (Cloud Firestore)**
- **State Management:** Bloc / Cubit / Provider

---

## 🚀 How to Run Locally

1. Clone the repo:
   ```bash
   git clone https://github.com/Carine-Ashimwe/Individual_assignment_note_app.git
   cd Individual_assignment_note_app
