//
//  AddFriendsView.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/9.
//


import SwiftUI

struct AddFriendView: View {
    @ObservedObject var addressBookViewModel: AddressBookViewModel
    @Environment(\.dismiss) private var dismiss
    
    var addressCard: AddressCard // The AddressCard to which friends will be added
    
    @State private var selectedFriendIds: Set<UUID> = [] // To store selected friends
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(addressBookViewModel.cards.filter { $0.id != addressCard.id }, id: \.id) { card in
                        HStack {
                            Text("\(card.vorname) \(card.nachname)")
                            Spacer()
                            if selectedFriendIds.contains(card.id) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle()) // Make the whole row tappable
                        .onTapGesture {
                            toggleSelection(for: card)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                
                Spacer()
                
                Button("OK") {
                    saveFriends()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Edit Friends")
            .onAppear(perform: loadFriends)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func loadFriends() {
        selectedFriendIds = Set(addressCard.freunde)
    }
    
    private func toggleSelection(for card: AddressCard) {
        if selectedFriendIds.contains(card.id) {
            selectedFriendIds.remove(card.id) // Unselect to remove as a friend
        } else {
            selectedFriendIds.insert(card.id) // Select to add as a friend
        }
    }
    
    private func saveFriends() { // Set contains only unique values
        let currentFriendIds = Set(addressCard.freunde)
        let friendsToAdd = selectedFriendIds.subtracting(currentFriendIds)
        let friendsToRemove = currentFriendIds.subtracting(selectedFriendIds)
        
        for friendId in friendsToAdd {
            if let friend = addressBookViewModel.cards.first(where: { $0.id == friendId }) {
                addressCard.add(friend: friend)
                print("Added friend: \(friend.vorname) \(friend.nachname)")
            }
        }
        for friendId in friendsToRemove {
            if let friend = addressBookViewModel.cards.first(where: { $0.id == friendId }) {
                addressCard.remove(friend: friend)
                print("Removed friend: \(friend.vorname) \(friend.nachname)")
            }
        } 
        addressBookViewModel.save()
        addressBookViewModel.updateViews()
        dismiss()
    }
}
