//
//  MerchantViewDisplayView.swift
//  TinFood
//
//  Created by Nhật Quân on 19/09/2023.
//

import SwiftUI

struct MerchantViewDisplayView: View {
    @State private var merchant:String = ""
    // our movie view model object
    @StateObject private var merchantViewModel = MerchantViewModel()
    var body: some View {
        VStack{
            // input field for a movie name
            NavigationView {
                List {
                    ForEach(merchantViewModel.merchants, id: \.id) { merchant in
                        Text(merchant.storename ?? "")
                        Text(merchant.username ?? "")
                        Text(merchant.password ?? "")
                        AsyncImage(url: URL(string: merchant.image ?? ""))
                            
                    }
                }
                .navigationTitle("All Movies")
                // List of all movies name fetched from firestore
                
            }}
    }
    
}

struct MerchantViewDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantViewDisplayView()
    }
}
