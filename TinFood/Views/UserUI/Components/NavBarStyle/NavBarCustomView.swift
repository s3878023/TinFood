//
//  NavBarCustomView.swift
//  Tinfood
//
//  Created by Khoa Dang Hoang Anh on 13/09/2023.
//

import SwiftUI

struct NavBarCustomView: View {
    var mainNavSections: [MainNavSection] = [
        .init(name: "Thích", isSelected: false),
        .init(name: "Siêu thích", isSelected: false),
        .init(name: "Khuyến mãi", isSelected: false)
    ]
    
    struct MainNavSection: Hashable {
        var name: String
        var isSelected: Bool
    }
    @Environment(\.presentationMode) var presentationMode
    let displayArrowBackButton: Bool
    let title: String
    let subtitle: String?
    
    
    
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
            NavBarCustomView(displayArrowBackButton: true, title: "Title", subtitle: "Subtitle")
            Spacer()
        }
    }
}


extension NavBarCustomView {
    private var backArrowButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSec: some View {
        VStack(spacing: 4){
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            if let subtitle = subtitle {
                Text(subtitle)
                    .padding(.bottom, 10)
            }
            HStack{
                    ForEach(mainNavSections, id: \.name) { section in
                        NavCustomLink(destination: ResDetailView(), label: {Text(section.name)})
                        .padding(.trailing)
                    }
            }
        }
    }
}

