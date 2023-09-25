//
//  Shop.swift
//  TinFood
//
//  Created by Đại Đức on 15/09/2023.
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Duc Dai  ID: s3878023
  Created  date: 15/09/2023.
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


struct Shop: Identifiable{
    var id = UUID().uuidString
    var storename: String
    var documentID: String?
    var address: String
    var image: String
    
    var foodTests: [FoodTest]?
}

