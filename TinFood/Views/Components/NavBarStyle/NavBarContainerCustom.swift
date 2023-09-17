//
//  NavBarContainerCustom.swift
//  Tinfood
//
//  Created by Khoa Dang Hoang Anh on 13/09/2023.
//

import SwiftUI

struct NavBarContainerCustom<Content: View> : View {
    let content: Content
    init(@ViewBuilder content: () -> Content){
        self .content = content()
    }
    
    var body: some View {
        VStack(spacing: 0){
            NavBarCustomView()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct NavBarContainerCustom_Previews: PreviewProvider {
    static var previews: some View {
        NavBarContainerCustom{
            Color(hex: 0xfaf1e8).ignoresSafeArea()
        }
    }
}
