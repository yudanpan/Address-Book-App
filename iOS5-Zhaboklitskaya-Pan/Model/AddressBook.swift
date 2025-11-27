//
//  AddressBook.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import Foundation

class AddressBook: Codable {
    var cards = [AddressCard]()
    
    init() {
        self.cards = []
        loadFromFile()
    }
    
    func add(card: AddressCard) {
        cards.append(card)
    }
    
    func remove(card: AddressCard) {
        if let index = cards.firstIndex(of: card){
            cards.remove(at: index)
            
            for i in 0..<cards.count {
                if let friendIndex = cards[i].freunde.firstIndex(of: card.id) {
                    cards[i].freunde.remove(at: friendIndex)
                }
            }
        } else {
            print("Card not found.")
        }
    }
    
    func sortBookByLastName() {
        cards.sort(by: {$0.nachname < $1.nachname})
    }
    
    func searchForLastname(nachname: String) -> AddressCard? {
        if let index = cards.firstIndex(where: { $0.nachname == nachname}){
            return cards[index]
        } else {
            return nil
        }
    }
    
    func searchForId(id: UUID) -> AddressCard? {
        if let index = cards.firstIndex(where: { $0.id == id}){
            return cards[index]
        } else {
            print("Card not found.")
        }
        return nil
    }
    
    func friendsOf(card: AddressCard) -> [AddressCard] {
        var friendsOfArray = [AddressCard] ()
        for friendId in card.freunde {
            if let friendCard = searchForId(id: friendId) {
                friendsOfArray.append(friendCard)
            }
        }
        return friendsOfArray
    }
    
    func saveToFile() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self) {
            let url = getFilePath()
            try? data.write(to: url)
        }
    }
    func loadFromFile() {
        let decoder = JSONDecoder()
        let url = getFilePath()
        if let data = try? Data(contentsOf: url), let loadedAddressBook = try? decoder.decode(AddressBook.self, from: data) {
            self.cards = loadedAddressBook.cards
        }
    }
    private func getFilePath() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("AddressBook.json")
    }
}
