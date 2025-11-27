//
//  Untitled.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/11/27.
//

# Address Book App (SwiftUI · MVVM)

A simple iOS Address Book application built using SwiftUI and the MVVM architecture pattern.
Users can create and manage contact cards, add or remove hobbies, maintain friendships between contacts, and persist all data locally using UUID-based JSON storage.

## Features
### Contact Management
Add new contacts with: Name, Address information, List of hobbies, Edit existing contacts, Remove contacts
### Friend Management
Add a friend from within the address book, remove friends.
Friend relationships update automatically on save
### Modern SwiftUI Interface
Uses native SwiftUI components
Clean and minimal UI design
Contact data is encoded/decoded using JSONReactive UI updates driven by MVVM architecture
### Local Persistence
Each contact is uniquely identified with a UUID
Contact data is encoded/decoded using JSON
Data is persisted locally and automatically loaded when the app starts

## Architecture
This project follows Model–View–ViewModel
Model - Codable models for JSON serialization: AddressBook, AddressCard, Hobby
View - SwiftUI views for forms, lists
ViewModel - Business logic and state management, Load/save JSON, Handle add/remove operations
                            
## License
This project is open-source and available under the MIT License.
