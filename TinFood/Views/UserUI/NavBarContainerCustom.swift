//
//  NavBarContainerCustom.swift
//  Tinfood
//
//  Created by Khoa Dang Hoang Anh on 13/09/2023.
//

import SwiftUI

struct NavBarContainerCustom<Content: View> : View {
    let content: Content
    @State private var displayArrowBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil //nil
    
    init(@ViewBuilder content: () -> Content){
        self .content = content()
    }
    
    var body: some View {
        ZStack{
            Color(hex: 0xfaf1e8).ignoresSafeArea()
            VStack(spacing: 0){
                NavBarCustomView(displayArrowBackButton: displayArrowBackButton, title: title, subtitle: subtitle)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onPreferenceChange(NavBarTitleCustomPreferenceKey.self ,perform: { value in
                self.title = value
                
            })
            .onPreferenceChange(NavBarSubTitleCustomPreferenceKey.self ,perform:{ value in
                self.subtitle = value
            })
            .onPreferenceChange(NavBarBackButtonHiddenCustomPreferenceKey.self,perform: { value in
                self.displayArrowBackButton = !value
            })
        }
    }
}

struct NavBarContainerCustom_Previews: PreviewProvider {
    static var previews: some View {
        NavBarContainerCustom{
            ZStack{
//                Color(hex: 0xfaf1e8).ignoresSafeArea()
                
                Text("Hello World")
                    .customNavTitle("Title")
                    .customNavSubTitle("Subtitle")
                    .customBackButtonHidden(true)
            }
        }
    }
}
