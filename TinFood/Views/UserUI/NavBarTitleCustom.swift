//
//  NavBarTitleCustom.swift
//  Tinfood
//
//  Created by Bảo Khương Đặng Hoàng on 19/09/2023.
//

import SwiftUI

struct NavBarTitleCustomPreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct NavBarSubTitleCustomPreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct NavBarBackButtonHiddenCustomPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    func customNavTitle(_ title: String) -> some View{
        preference(key: NavBarTitleCustomPreferenceKey.self, value: title)
    }
    
    func customNavSubTitle (_ subtitle: String?) -> some View {
        preference(key: NavBarSubTitleCustomPreferenceKey.self, value: subtitle)
    }
    
    func customBackButtonHidden (_ hidden: Bool) -> some View{
        preference(key: NavBarBackButtonHiddenCustomPreferenceKey.self, value: hidden)
    }
    
    func CustomNavBarItems (title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self
            .customNavTitle(title)
            .customNavSubTitle(subtitle)
            .customBackButtonHidden(backButtonHidden)
    }
}
