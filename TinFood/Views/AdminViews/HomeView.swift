//
//  HomeView.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 0) {
            AppBarView(viewModel: viewModel, width: UIScreen.main.bounds.width)
                .background(Color("CustomedYellow"))
                .padding(.bottom)

            GeometryReader { g in
                HStack(spacing: 0) {
                    FirstView(viewModel: viewModel)
                        .frame(width: g.frame(in: .global).width)

                    ScndView(viewModel: viewModel)
                        .frame(width: g.frame(in: .global).width)

                    ThirdView(viewModel: viewModel)
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
        }
        .background(Color("CustomedYellow"))
        .animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
}
