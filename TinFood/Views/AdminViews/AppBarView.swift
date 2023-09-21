//
//  AppBarView.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct AppBarView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var showActionSheet = false
    @State private var selection = "None"
    var width: CGFloat // Add this property

    init(viewModel: HomeViewModel, width: CGFloat) {
        self.viewModel = viewModel
        self.width = width
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 55)
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
                    }
                }
            }
            .padding(.bottom)
            .padding(.horizontal)
            HStack {
                Button(action: {
                    viewModel.index = 1
                    viewModel.offset = 0
                }) {
                    VStack(spacing: 8) {
                        Text("Users")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(viewModel.index == 1 ? Color("text") : Color("text").opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 1 ? Color("myYellow") : Color.clear)
                                    .frame(height: 3)
                                    .offset(y: 14)
                            )
                        Text("")
                    }
                    .padding(.leading, 10)
                }
                Button(action: {
                    viewModel.index = 2
                    viewModel.offset = Int(-self.width)
                }) {
                    VStack(spacing: 8) {
                        Text("Merchants")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(viewModel.index == 2 ? Color("text") : Color("text").opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 2 ? Color("myYellow") : Color.clear)
                                    .frame(height: 3)
                                    .offset(y: 14)
                            )
                        Text("")
                    }
                    .padding(.leading, 50)
                    .padding(.trailing, 30)
                }
                Button(action: {
                    viewModel.index = 3
                    viewModel.offset = Int(-self.width-self.width)
                }) {
                    VStack(spacing: 8) {
                        Text("All Users")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(viewModel.index == 3 ? Color("text") : Color("text").opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 3 ? Color("myYellow") : Color.clear)
                                    .frame(height: 3)
                                    .offset(y: 14)
                            )
                        Text("")
                    }
                }
            }
        })
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
        .padding(.horizontal)
        .padding(.bottom, 0)
        .background(Color("components"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

