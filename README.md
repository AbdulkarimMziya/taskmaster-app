<p align="center">
   <img src="https://github.com/AbdulkarimMziya/AbdulkarimMziya/blob/main/images/RemainderAppDemo.gif" alt="Taskmaster Demo" width="150"/> 
</p>


# TaskMaster

A simple iOS task management app built with Swift and UIKit that lets you create, edit, and delete tasks via a custom REST API.

## Features

- View all tasks in a clean table view
- Add new tasks with a title and completion status
- Edit existing tasks inline
- Swipe to delete tasks
- Live sync with a Node.js/Express + MongoDB backend

## Requirements

- **iOS** 16.0+
- **Xcode** 15.0+
- **Swift** 5.9+
- **Node.js** 18.0+
- A running instance of the [TaskMaster Backend](https://github.com/AbdulkarimMziya/taskmaster-backend)

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/AbdulkarimMziya/taskmaster-app.git
cd taskmaster-app
```

### 2. Start the API server

Clone and run the backend from [taskmaster-backend](https://github.com/AbdulkarimMziya/taskmaster-backend):
```bash
git clone https://github.com/AbdulkarimMziya/taskmaster-backend.git
cd taskmaster-backend
npm install
node index.js        # or: nodemon index.js
```

The server runs on `http://localhost:4000` by default.

### 3. Open and run the iOS app

Open `taskmaster-app.xcodeproj` in Xcode, select a simulator or connected device, and press **Run** (⌘R).

> **Note:** The iOS app points to `http://localhost:4000` by default. If running on a physical device, update the host in `TaskAPIService.swift` to your machine's local IP address.

## Architecture

The project follows the **MVC (Model-View-Controller)** pattern and uses modern Swift concurrency (`async`/`await`).
```
taskmaster-app/
├── Models/
│   └── TodoTask.swift                      # Codable task model
├── Controllers/
│   ├── ViewController.swift                # Main task list screen
│   └── TaskDetailViewController.swift      # Add/edit task screen
├── Network Services/
│   ├── TaskAPIService.swift                # CRUD API calls
│   └── NetworkHelper.swift                 # URLSession wrapper
├── Protocols/
│   ├── TaskDetailDelegate.swift            # Save callback protocol
│   └── TaskDetailDelegateExtension.swift   # ViewController conformance
```

### Key components

| Component | Responsibility |
|-----------|---------------|
| `ViewController` | Displays task list, handles swipe-to-delete |
| `TaskDetailViewController` | Add/edit form with title field and completion toggle |
| `TaskAPIService` | Semantic CRUD methods wrapping URLSession requests |
| `NetworkHelper` | Thread-safe URLSession actor |
| `TaskDetailDelegate` | Callback protocol to reload task list after save |
| `TodoTask` | Codable model mapping `_id` from MongoDB |

## API

The app communicates with a local Express + MongoDB REST API. See [taskmaster-backend](https://github.com/AbdulkarimMziya/taskmaster-backend) for full setup details.

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/tasks` | Fetch all tasks |
| `POST` | `/api/task` | Create a new task |
| `PUT` | `/api/task/:id` | Update a task |
| `DELETE` | `/api/task/:id` | Delete a task |

## License

This project is available for personal and educational use.
