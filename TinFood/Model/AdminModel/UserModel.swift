//
//  UserModel.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable {
    let id = UUID()
    let name: String
    var isMerchant: Bool = false
    var isBanned: Bool = false
}

