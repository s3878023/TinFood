//
//  UserModel.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct UserModel {
    let id = UUID().uuidString
    var name: String?
    var documentID: String?
    var isMerchant: Bool?
}

