//
//  UserModel.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    var name: String?
    var place: String?
    var profilePic: String?
    var documentID: String?
    var isMerchant: Bool?
    var isAdmin: Bool?
    var username, password, storename,image : String?
}

