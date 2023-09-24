//
//  TestingVieww.swift
//  TinFood
//
//  Created by Nhật Quân on 24/09/2023.
//

import SwiftUI

struct TestingVieww: View {
    @State private var isOpen: [String: Bool] = [:] // Use a dictionary to store expansion states

    let items: [Item] = [
        Item(name: "Item 1", details: ["Detail 1", "Detail 2"]),
        Item(name: "Item 2", details: ["Detail 3", "Detail 4"]),
        Item(name: "Item 3", details: ["Detail 3", "Detail 4"]),
        Item(name: "Item 4", details: ["Detail 3", "Detail 4"])
    ]

    var body: some View {
        List(items, id: \.id) { item in
            DisclosureGroup(item.name, isExpanded: Binding(
                get: { isOpen[item.id.uuidString] ?? false },
                set: { isOpen[item.id.uuidString] = $0 }
            )) {
                ForEach(item.details, id: \.self) { detail in
                    Text(detail)
                }
            }
        }
    }
}

struct TestingVieww_Previews: PreviewProvider {
    static var previews: some View {
        TestingVieww()
    }
}

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let details: [String]
}
