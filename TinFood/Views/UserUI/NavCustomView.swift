//
//  NavCustomView.swift
//  Tinfood
//
//  Created by Khoa Dang Hoang Anh on 13/09/2023.
//

import SwiftUI

struct NavCustomView<Content: View>: View {
    let content: Content
    
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView{
            NavBarContainerCustom {
                content
            }
            .navigationBarHidden(true)
        }
        .background(Color(hex: 0xfaf1e8))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavCustomView_Previews: PreviewProvider {
    static var previews: some View {
        NavCustomView{
            Color(hex: 0xfaf1e8).ignoresSafeArea()
        }
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
