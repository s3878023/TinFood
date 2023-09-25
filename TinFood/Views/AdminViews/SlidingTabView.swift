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

struct SlidingTabView: View {
    @StateObject var viewModel = HomeViewModel()
    @ObservedObject var loginViewModel = LoginViewModel()

    var body: some View {
        HomeView(viewModel: viewModel, loginViewModel: loginViewModel)
    }
}
struct SlidingTabView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingTabView()
    }
}
