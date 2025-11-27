//
//  iOS5_Zhaboklitskaya_PanApp.swift
//  iOS5-Zhaboklitskaya-Pan
//
//  Created by Yudan on 2025/1/2.
//

import SwiftUI

@main
struct iOS5_Zhaboklitskaya_PanApp: App {
    var body: some Scene {
        WindowGroup {
            AddressBookView(addressBookViewModel: AddressBookViewModel())
        }
    }
}
