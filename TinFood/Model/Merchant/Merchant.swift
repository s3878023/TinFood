//
//  Merchant.swift
//  TinFood
//
//  Created by Nhật Quân on 19/09/2023.
//

import Foundation
import SwiftUI

struct Merchant: Codable,Identifiable{
    var id: String = UUID().uuidString
    var username, password, storename, image,description, category, price,foodname : String?
}
