//
//  AddHobbyView.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Veronika Zhaboklitskaya on 07.01.25.
//

import SwiftUI

struct AddHobbyView: View {
    @ObservedObject var addressBookViewModel: AddressBookViewModel
    @State private var hobbyName: String = ""
    @State private var isAddingHobby = false
    @Environment(\.dismiss) private var dismiss
    
    var addressCard: AddressCard // The AddressCard to which this hobby will be added
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                        TextField("Hobby", text: $hobbyName)
                            .textFieldStyle(.roundedBorder)
                }
                Button("Add") {
                    addHobby()
                }
                .padding([.top, .bottom], 50)
                .disabled(!isFormValid || isAddingHobby) // Disable if form is invalid or hobby is being added
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .navigationTitle("New Hobby")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !hobbyName.isEmpty
    }
    
    private func addHobby() {
        
        guard isFormValid else { return }
        
        let newHobby = Hobby(id: UUID(), name: hobbyName)
        
        addressCard.add(hobby: newHobby)
        addressBookViewModel.save()
        addressBookViewModel.updateViews()
   
        dismiss()
    }
}

