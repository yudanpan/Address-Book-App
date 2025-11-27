//
//  Hobby.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import Foundation

class Hobby: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    
    init(id: UUID, name: String) {
        self.name = name
        self.id = UUID()
    }
    
    static func == (left: Hobby, right: Hobby) -> Bool {
        return left.id == right.id
    }
}
