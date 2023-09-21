//
//  NavCustomLink.swift
//  Tinfood
//
//  Created by Bảo Khương Đặng Hoàng on 19/09/2023.
//

import SwiftUI




struct NavCustomLink <Label : View, Destination: View>:View {
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: ()-> Label){
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination: NavBarContainerCustom(content: {
                destination})
            .navigationBarBackButtonHidden()
            ,
            label: {
                label
            }
        )
    }
}

struct NavCustomLink_Previews: PreviewProvider {
    static var previews: some View {
        NavCustomView{
            NavCustomLink(
                destination: Text("Destination")){
                Text("Destination")}
        }
    }
}


