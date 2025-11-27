//
//  AddCardView.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import SwiftUI

struct AddCardView: View {
    @ObservedObject var addressBookViewModel: AddressBookViewModel
    @State private var vorname: String = ""
    @State private var nachname: String = ""
    @State private var strasseMitHausnummer: String = ""
    @State private var postleitzahl: String = ""
    @State private var ort: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Personal Information")) {
                        TextField("First Name", text: $vorname)
                            .textFieldStyle(.roundedBorder)
                        TextField("Last Name", text: $nachname)
                            .textFieldStyle(.roundedBorder)
                        TextField("Street and House Number", text: $strasseMitHausnummer)
                            .textFieldStyle(.roundedBorder)
                        TextField("Postal Code", text: $postleitzahl)
                            .textFieldStyle(.roundedBorder)
                        TextField("City", text: $ort)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                Button("Add") {
                    addCard()
                }
                .padding([.top, .bottom], 50)
                .disabled(!isFormValid)
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            
            .navigationTitle("New Contact")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Close"){
                        dismiss()
                    }
                }
            }
            
        }
    }
    
    private var isFormValid: Bool {
        !vorname.isEmpty &&
        !nachname.isEmpty &&
        !strasseMitHausnummer.isEmpty &&
        !postleitzahl.isEmpty &&
        !ort.isEmpty &&
        Int(postleitzahl) != nil
    }
    
    private func addCard() {
        if (isFormValid) {
            addressBookViewModel.addCard(
                vorname: vorname,
                nachname: nachname,
                strasseMitHausnummer: strasseMitHausnummer,
                postleitzahl: postleitzahl,
                ort: ort
            )
        }
        dismiss()
    }
}


