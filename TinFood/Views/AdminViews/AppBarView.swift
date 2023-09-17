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
    var width: CGFloat // Add this property

    init(viewModel: HomeViewModel, width: CGFloat) {
        self.viewModel = viewModel
        self.width = width
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Button(action: {
                    viewModel.index = 1
                    viewModel.offset = 0
                }) {
                    VStack(spacing: 8) {
                        Text("User")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(viewModel.index == 1 ? .black : Color.black.opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 1 ? Color.yellow : Color.clear)
                                    .frame(height: 3)
                                    .offset(y: 14)
                            )
                        Text("")
                    }
                    .padding(.horizontal, 18.6)
                }
                Button(action: {
                    viewModel.index = 2
                    viewModel.offset = Int(-self.width)
                }) {
                    VStack(spacing: 8) {
                        Text("Merchants")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(viewModel.index == 2 ? .black : Color.black.opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 2 ? Color.yellow : Color.clear)
                                    .frame(height: 3)
                                    .offset(y: 14)
                            )
                        Text("")
                    }
                    .padding(.horizontal, 18.6)
                }
                Button(action: {
                    viewModel.index = 3
                    viewModel.offset = Int(-self.width-self.width)
                }) {
                    VStack(spacing: 8) {
                        Text("Reported")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(viewModel.index == 3 ? .black : Color.black.opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.index == 3 ? Color.yellow : Color.clear)
                                    .frame(height: 3)
                                    .offset(y: 14)
                            )
                        Text("")
                    }
                    .padding(.horizontal, 18.6)
                }
            }
        })
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
        .padding(.horizontal)
        .padding(.top, 30)
        .padding(.bottom, 0)
        .background(Color("CustomedPink"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

