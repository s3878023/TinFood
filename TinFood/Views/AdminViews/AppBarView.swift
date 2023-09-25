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

struct AppBarView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var showActionSheet = false
    @State private var selection = "None"
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    var width: CGFloat // Add this property

    init(viewModel: HomeViewModel, width: CGFloat, loginViewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.width = width
        self.loginViewModel = loginViewModel
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Spacer()
                Button(action: {
                    isDarkMode.toggle()
                }, label: {
                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundColor(Color("button"))
                })
                Spacer()
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 55)
                Spacer()
                Spacer()
                Button {
                    showActionSheet = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color("button"))
                }
                .confirmationDialog("Do you want to log out ?", isPresented: $showActionSheet, titleVisibility: .visible){
                    Button("Log out", role: .destructive){
                        selection = "Log out"
                        loginViewModel.logout()
                    }
                }
            }
            .padding(.bottom)
            .padding(.horizontal)
            HStack {
                Spacer()
                Button(action: {
                    viewModel.index = 1
                    viewModel.offset = 0
                }) {
                    VStack(spacing: 8) {
                        Text("Users")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .foregroundColor(viewModel.index == 1 ? Color("text") : Color("text").opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 1 ? Color("myYellow") : Color.clear)
                                    .frame(height: 5)
                                    .offset(y: 20)
                            )
                        Text("")
                    }
                    .padding(.leading, 10)
                }
                Spacer()
                Button(action: {
                    viewModel.index = 2
                    viewModel.offset = Int(-self.width)
                }) {
                    VStack(spacing: 8) {
                        Text("Merchants")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .foregroundColor(viewModel.index == 2 ? Color("text") : Color("text").opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 2 ? Color("myYellow") : Color.clear)
                                    .frame(height: 5)
                                    .offset(y: 20)
                            )
                        Text("")
                    }
                }
                Spacer()
            }
        })
        .preferredColorScheme(isDarkMode ? .light : .dark)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
        .padding(.horizontal)
        .padding(.bottom, 0)
        .background(Color("components"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

