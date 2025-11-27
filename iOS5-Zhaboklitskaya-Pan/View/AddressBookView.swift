//
//  AddressBookView.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import SwiftUI

struct AddressBookView: View {
    @ObservedObject var addressBookViewModel: AddressBookViewModel
    @State private var isEditing = false
    @State private var showingAddCardView = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(addressBookViewModel.cards.indices, id: \.self) { index in
                    HStack {
                        if isEditing {
                            Button(role: .destructive) {
                                addressBookViewModel.remove(card: addressBookViewModel.cards[index])
                            } label: {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(.plain)
                            .padding(.trailing, 5)
                        }
                        ContactRow(addressBookViewModel: addressBookViewModel, card: $addressBookViewModel.cards[index])
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(isEditing ? "OK" : "Edit"){
                        withAnimation{
                            isEditing.toggle()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showingAddCardView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            
            .sheet(isPresented: $showingAddCardView) {
                AddCardView(addressBookViewModel: addressBookViewModel)
            }
            .onAppear {
                addressBookViewModel.sort()
            }
            .onDisappear {
                addressBookViewModel.save()
            }
        }
        
    }
}
