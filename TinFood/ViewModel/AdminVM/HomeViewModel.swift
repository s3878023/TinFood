//
//  HomeViewModel.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var users: [UserModel] = [
        UserModel(name: "User 1"),
        UserModel(name: "User 2"),
        UserModel(name: "User 3"),
        UserModel(name: "Merchant1", isMerchant: true),
        UserModel(name: "Merchant2", isMerchant: true),
        UserModel(name: "Merchant3", isMerchant: true),
    ]
    @Published var searchText: String = ""
    @Published var index: Int = 1
    @Published var offset = 0
    @Published var showMoreOptions: Bool = false
    var width = UIScreen.main.bounds.width

    var filteredUsers: [UserModel] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func banUser(user: UserModel) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index].isBanned.toggle()
        }
    }
    func changeView(left: Bool) {

        if left {

            if self.index != 3 {

                self.index += 1
            }
        } else {

            if self.index != 1 {

                self.index -= 1
            }
        }

        if self.index == 1 {

            self.offset = 0
        } else if self.index == 2 {

            self.offset = Int(-self.width)
        } else {
            self.offset = Int(-self.width - self.width)
        }
    }
}
