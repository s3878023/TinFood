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

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            AppBarView(viewModel: viewModel, width: UIScreen.main.bounds.width, loginViewModel: loginViewModel)
                .background(Color("background"))
                .padding(.bottom)

            GeometryReader { g in
                HStack(spacing: 0) {
                    FirstView(viewModel: viewModel)
                        .frame(width: g.frame(in: .global).width)

                    ScndView(viewModel: viewModel)
                        .frame(width: g.frame(in: .global).width)
                    
                }
                .offset(x: CGFloat(viewModel.offset))
                .highPriorityGesture(DragGesture()
                    .onEnded({ value in
                        if value.translation.width > 50 {
                            viewModel.changeView(left: false)
                        }
                        if -value.translation.width > 50 {
                            viewModel.changeView(left: true)
                        }
                    }))
            }
            Spacer()
        }
        .background(Color("background"))
        .animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
}
