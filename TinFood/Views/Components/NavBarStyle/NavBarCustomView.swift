//
//  NavBarCustomView.swift
//  Tinfood
//
//  Created by Khoa Dang Hoang Anh on 13/09/2023.
//

import SwiftUI

struct NavBarCustomView: View {
    
    @State private var displayArrowBackButton: Bool = true
    @State private var title: String = "Title"
    @State private var subtitle: String? = "Subtitle" //nil
    
    var mainNavSections: [MainNavSection] = [
        .init(name: "Thích", isSelected: false),
        .init(name: "Siêu thích", isSelected: false),
        .init(name: "Khuyến mãi", isSelected: false)
    ]
    
    
    var body: some View {
        VStack{
            HStack{
                if displayArrowBackButton {
                    backArrowButton
                }
                Spacer()
                titleSec
                Spacer()
                if displayArrowBackButton {
                    backArrowButton
                        .opacity(0)
                }
            }
            
            HStack{
                
            }
        }
        .padding()
        .accentColor(Color(hex: 0x383838))
        .foregroundColor(Color(hex: 0x383838))
        .font(.headline)
        .background(Color(hex: 0xfcd4c8))
    }
}

struct NavBarCustomView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            NavBarCustomView()
            Spacer()
        }
    }
}

struct MainNavSection: Hashable {
    let name: String
    let isSelected: Bool
}

extension NavBarCustomView {
    private var backArrowButton: some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSec: some View {
        VStack(spacing: 4){
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle = subtitle {
                Text(subtitle)
            }
        }
    }
}
