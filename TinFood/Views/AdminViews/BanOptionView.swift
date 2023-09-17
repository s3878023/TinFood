//
//  BanOptionView.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

struct BanOptionsView: View {
    let user: UserModel

    var body: some View {
        VStack {
            Text("User: \(user.name)")
            Button(action: {
                // Implement your logic to ban/unban the user here.
                // You can access user.isBanned to check the ban status.
                print("User \(user.name) isBanned: \(user.isBanned)")
            }) {
                Text(user.isBanned ? "Unban" : "Ban")
                    .foregroundColor(user.isBanned ? .green : .red)
            }
        }
        .padding()
    }
}
