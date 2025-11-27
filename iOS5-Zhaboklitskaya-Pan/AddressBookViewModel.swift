//
//  AddressBookViewModel.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import SwiftUI

class AddressBookViewModel: ObservableObject {
    @Published private var addressBookModel = AddressBook()
//    let filePath: String
    
    func updateViews(){
        objectWillChange.send()
    }
    
    var cards: [AddressCard] {
        get {
            addressBookModel.cards
        }
        set {
            addressBookModel.cards = newValue
        }
    }
    
    func friends(for card: AddressCard) -> [AddressCard] {
        addressBookModel.friendsOf(card: card)
    }
    
    func remove(card: AddressCard){
        addressBookModel.remove(card: card)
        save()
    }
    
    func addCard(vorname: String, nachname: String, strasseMitHausnummer: String, postleitzahl: String, ort: String) {
            let newCard = AddressCard(
                id: UUID(),
                vorname: vorname,
                nachname: nachname,
                strasseMitHausnummer: strasseMitHausnummer,
                postleitzahl: postleitzahl,
                ort: ort,
                hobbys: [],
                freunde: []
            )
            addressBookModel.add(card: newCard)
            sort()
            save()
        }
    
    func sort(){
        addressBookModel.sortBookByLastName()
        updateViews()
    }
    
    func save() {
        addressBookModel.saveToFile()
        updateViews()
    }
}
