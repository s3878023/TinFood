//
//  SlidingTabView.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

struct SlidingTabView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        HomeView(viewModel: viewModel, loginViewModel: LoginViewModel())
    }
}
struct SlidingTabView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingTabView()
    }
}
