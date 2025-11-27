//
//  AddressCard.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import Foundation

class AddressCard : Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var vorname: String
    var nachname: String
    var strasseMitHausnummer: String
    var postleitzahl: String
    var ort: String
    var hobbys: [Hobby]
    var freunde: [UUID]
    
    init(id: UUID = UUID(), vorname: String, nachname: String, strasseMitHausnummer: String, postleitzahl: String, ort: String, hobbys: [Hobby] = [], freunde: [UUID] = []) {
        self.id = UUID()
        self.vorname = vorname
        self.nachname = nachname
        self.strasseMitHausnummer = strasseMitHausnummer
        self.postleitzahl = postleitzahl
        self.ort = ort
        self.hobbys = hobbys
        self.freunde = freunde
    }
    
    static func == (left: AddressCard, right: AddressCard) -> Bool {
        return left.id == right.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func add(hobby: Hobby) {
        hobbys.append(hobby)
    }
    
    func remove(hobby: Hobby) {
        if let index = hobbys.firstIndex(of: hobby){
            hobbys.remove(at: index)
        } else {
            print("Hobby not found.")
        }
    }
    
    func add(friend: AddressCard) {
        freunde.append(friend.id)
    }
    
    func remove(friend: AddressCard) {
        if let index = freunde.firstIndex(of: friend.id){
            freunde.remove(at: index)
        } else {
            print("Friend not found.")
        }
    }
}

