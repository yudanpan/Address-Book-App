//
//  ContactRowView.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import SwiftUI

struct ContactRow: View {
    @ObservedObject var addressBookViewModel: AddressBookViewModel
    @Binding var card: AddressCard
//    let card: AddressCard
    var body: some View {
        NavigationLink {
            AddressBookDetailView(addressCard: $card)
                .environmentObject(addressBookViewModel)
        } label: {
            VStack(alignment: .leading) {
                Text("\(card.vorname) \(card.nachname)")
                    .font(.headline)
                Text("\(card.strasseMitHausnummer), \(card.postleitzahl) \(card.ort)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
