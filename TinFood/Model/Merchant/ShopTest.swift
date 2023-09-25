/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tong Nhat Quan  ID: s3819347
  Created  date: 13/09/2023.
  Last modified: 25/09/2023
  Acknowledgement:
    RMIT Lecture Slides https://rmit.instructure.com/courses/121597
    OpenChatAI: https://chat.openai.com/
    Github: https://github.com/s3878023/TinFood/tree/dev
    SFSymbols
    StackOverFlow: https://stackoverflow.com/
*/
import Foundation

import SwiftUI

struct ShopTest : Codable,Identifiable{
    var id: String = UUID().uuidString
    var username, password, storename, image,address: String?
    var foodTests: [FoodTest]?
}
