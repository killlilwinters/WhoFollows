<h2 align="center">WhoFollows</h2>

<div align="center">
  <img src="https://github.com/user-attachments/assets/8a18786d-27a6-4f64-851f-372022370c48" alt="WhoFollowsAppIconDark" width="30%">
</div>

**WhoFollows** is a project based on the "iOS Dev Job Interview Practice - Take Home Project" course by renowned iOS developer Sean Allen. The app utilizes GitHub's REST API to allow users to search for GitHub profiles, view user details, browse followers/following lists, and manage favorites. Additionally, the app offers a seamless, modern, and user-friendly interface, ensuring an intuitive experience.

![WhoFollowsMain](https://github.com/user-attachments/assets/fa4f91db-65de-41ec-a473-1eecbb33edd2)

The primary goal of this project was to build a take-home style project using the UIKit framework while deepening knowledge of UIKit development principles.

## Screenshots

![WhoFollowsScreenshots](https://github.com/user-attachments/assets/1f12a7bf-2228-4616-98a9-a34208694cf9)


## Implementation

The app follows a modern approach to building and designing iOS applications. It is structured around the MVC (Model-View-Controller) architecture and leverages key UIKit components to create the User Interface.

### Frameworks and Core Technologies

- **Foundation**: Provides essential data types and collection handling.
- **UIKit (Programmatic)**: The primary UI framework for building the app's user interface.
- **SafariServices**: Enables in-app browsing with Safari View Controller.
- **CoreData**: Manages persistent storage for user favorites.
- **XCTest**: Implements unit and  testing to ensure app's logic stability.

### External Packages

- *(No external packages used in this project.)*



## Features

### Implemented in the Course Scope:

- Fetching followers and user information from GitHub's API.
- Displaying user details.
- Searching for GitHub users by username.
- Implementing pagination for data loading.
- Caching temporary images for performance optimization.
- Supporting light and dark mode.
- Integrating Safari View Controller for seamless web browsing.
- Using `Codable` for JSON parsing.

### Additional Features Implemented Beyond the Course:

- Fetching the "Following" list alongside followers.
- Dynamic search button adjustments based on user input.
- Improved empty state handling with dismissible views.
- Sharing user profile links via `UIActivityViewController`.
- Header and footer handling in `UserInfoVC`.
- `UserInfoVC` structured as a `UICollectionView` for flexibility.
- CoreData-based persistence for user favorites.
- UI elements dynamically scaling across different screen sizes.
- Disk-based image caching in `.cachesDirectory`.
- Rounded avatars implemented using `layoutIfNeeded` method.
- Custom `UIStackViews` with useful layout extensions.
- `WFAlertVC` now includes a delegate for improved dismissal handling.


## Skills Learned

### From the Course:

- Xcode features and development shortcuts.
- Code refactoring for maintainability.
- MVC architecture for app structure.
- Delegation pattern for component communication.
- Memory management with `weak` references.
- UIKit fundamentals:
  - `UIView`, `UIViewController`, `UITableView`, `UICollectionView`
  - `UINavigationController`, `UITabBarController`, `UISearchController`
  - `UISafariViewController`, `DiffableDataSource`, `NSCache`, `UserDefaults`
- Networking with `URLSession`, completion handlers, and async/await.

### Additional Skills Gained:

- Managing Xcode schemes, build phases, and test plans.
- Implementing access control best practices.
- Creating conditional protocol default implementations (`DataLoadingView`).
- Using `FileManager.default` and `.cachesDirectory` for local file storage.
- `UIActivityViewController` for sharing functionality.
- Mastering content hugging & resistance priority for better layouts.
- CoreData fundamentals and efficient data persistence strategies.
- XCTest fundamentals for test-driven development.
- LLDB debugging techniques for runtime issue resolution.
- Functional programming (`map`, `forEach`, `reduce`, etc.).
- Improved optional handling and error management.


## Development Challenges and Solutions

- **Adapting to Swift Concurrency**: Migrated code to leverage async/await for improved readability and performance.
- **Responsive UI on Small Screens**: Ensured dynamic scaling for devices like iPhone SE and mini models.
- **Optimized API Calls**: Reduced unnecessary network requests using `NSCache` and `.cachesDirectory`.
- **Improved Data Persistence**: Transitioned from UserDefaults to CoreData for better scalability.
- **Enhanced Empty State Handling**: Designed a more flexible and dismissible empty state UI.


## Installation

Follow these steps to build and run the app from source:

### 1. Clone the Repository

Clone the repository to your local machine:

```sh
git clone https://github.com/killlilwinters/WhoFollows
```

### 2. Open in Xcode

Navigate to the project directory and open the `.xcodeproj` file in Xcode.

### 3. Configure Signing & Capabilities

Ensure that your development team is selected in Xcode under **Signing & Capabilities**. You may need an Apple Developer account.

### 4. Run the App

Connect your device, select it in Xcode, and click **Run** to build and launch the app.

> *Note:* If you encounter provisioning issues, follow the on-screen prompts in Xcode.

## More

Video showcase can be found [HERE](https://youtube.com/shorts/pU8Lx0gqSHY).
