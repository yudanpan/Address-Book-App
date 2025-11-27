//
//  AddressBookDetailView.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import SwiftUI

struct AddressBookDetailView: View {
    @EnvironmentObject var addressBookViewModel: AddressBookViewModel
//    @State var addressCard: AddressCard
    @Binding var addressCard: AddressCard
    @State private var isEditingHobbies = false // Toggle for editing hobbies
    @State private var showingAddHobbyView = false
    @State private var showingAddFriendView = false

    var body: some View {
        VStack(spacing: 16) {
            
            // Personal Information Group (TextFields)
            Group {
                            TextField("First Name", text: $addressCard.vorname)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: addressCard.vorname) { oldValue, newValue in saveChanges() }
                            
                            TextField("Last Name", text: $addressCard.nachname)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: addressCard.nachname) { oldValue, newValue in saveChanges() }
                            
                            TextField("Street and House Number", text: $addressCard.strasseMitHausnummer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: addressCard.strasseMitHausnummer) { oldValue, newValue in saveChanges() }
                            
                            TextField("Postal Code", text: $addressCard.postleitzahl)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: addressCard.postleitzahl) { oldValue, newValue in saveChanges() }
                            
                            TextField("City", text: $addressCard.ort)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: addressCard.ort) { oldValue, newValue in saveChanges() }
                        }
                        .padding(.horizontal)

            // Hobbies Section
            VStack {
                HStack {
                    Text("Hobbies")
                        .font(.headline)
                    Spacer()
                    
                    // Add button (hidden in edit mode)
                    if !isEditingHobbies {
                        Button("Add") {
                            showingAddHobbyView = true
                        }
                    }
                    
                    // Edit/OK toggle button
                    Button(action: {
                        isEditingHobbies.toggle()
                    }) {
                        Text(isEditingHobbies ? "OK" : "Edit")
                            .foregroundColor(isEditingHobbies ? .red : .blue)
                    }
                }
                .padding(.horizontal)

                // List of hobbies
                List {
                    ForEach(addressCard.hobbys, id: \.id) { hobby in
                        HStack {
                            Text(hobby.name)
                                .padding(5)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                            Spacer()

                            // Delete button for hobbies when editing
                            if isEditingHobbies {
                                Button(role: .destructive) {
                                    addressCard.remove(hobby: hobby) // Remove hobby from address card
                                    addressBookViewModel.save()
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            
//            Spacer()
            
            // List of friends
            VStack {
                    HStack {
                                Text("Friends")
                                    .font(.headline)
                                Spacer()
                                Button("Edit") {
                                    showingAddFriendView = true
                                }
                                .foregroundColor(.blue)
                            }
                            .padding(.horizontal)

                            List {
                                ForEach(addressBookViewModel.friends(for: addressCard), id: \.id) { friend in
                                    VStack(alignment: .leading) {
                                        Text("\(friend.vorname) \(friend.nachname)")
                                            .font(.subheadline)
                                        Text("\(friend.strasseMitHausnummer), \(friend.postleitzahl) \(friend.ort)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                    }
        }

        .navigationTitle("\(addressCard.vorname) \(addressCard.nachname)")
        .padding(.top)
        .sheet(isPresented: $showingAddHobbyView) {
                   AddHobbyView(addressBookViewModel: addressBookViewModel, addressCard: addressCard)
               }
        .sheet(isPresented: $showingAddFriendView) {
                    AddFriendView(addressBookViewModel: addressBookViewModel, addressCard: addressCard)
                }
    }
    
    private func saveChanges() {
            if let index = addressBookViewModel.cards.firstIndex(where: { $0.id == addressCard.id }) {
                addressBookViewModel.cards[index] = addressCard
                addressBookViewModel.save()
            }
        }
}


