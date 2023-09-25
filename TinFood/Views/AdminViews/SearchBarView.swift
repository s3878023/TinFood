/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tranh Khanh Duc  ID: s3907087
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

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Search", text: $searchText)
                .padding(.horizontal, 35)
                .padding(.vertical, 5)
                .foregroundColor(Color("text"))
                .background(Color("row"))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .font(.system(size: 20))
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("text"))
                .padding(.leading, 8)
                .padding(.horizontal, 17)
        }
        .padding(.bottom, 10)
    }
}
