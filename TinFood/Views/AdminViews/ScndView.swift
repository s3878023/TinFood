//
//  ScndView.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

struct ScndView: View {
    @ObservedObject var viewModel: HomeViewModel
    let backgroundColor = Color("background")

    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.searchText)

            GeometryReader { geometry in
               ScrollView {
                   VStack {
                       NavigationView {
                           List{
                               ForEach(viewModel.filteredShops, id: \.id) { shop in
                                   MerchantsRowView(merchant: shop, viewModel: viewModel)
                                       .foregroundColor(Color("text"))
                                       .padding(.vertical, 18)
                                       .cornerRadius(10)
                                       .listRowSeparator(.hidden)
                                       .listRowBackground(
                                           RoundedRectangle(cornerRadius: 10)
                                               .fill(Color("row"))
                                               .frame(height: 60)
                                       )
                               }
                               .onDelete(perform: removeData)
                           }
                           .background(backgroundColor)
                           .listStyle(PlainListStyle())
                       }
                       .frame(height: geometry.size.height) // Set the frame height to match available height
                   }
                   .background(backgroundColor)
                   .padding(.bottom)
               }
           }
           .padding(.horizontal)
       }
       .background(backgroundColor)
       .sheet(isPresented: $viewModel.showMoreOptionsMerc) {
           if let selectedShop = viewModel.selectedShop {
               ShowMoreOptionViewMerc(viewModel: viewModel)
           }
       }
    }
    
    func removeData(at offsets: IndexSet){
        for index in offsets{
            if let documentID = viewModel.shops[index].documentID{
                viewModel.removeShopData(documentID: documentID)
            }
        }
    }
}
struct ScndView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        return ScndView(viewModel: viewModel)
    }
}
