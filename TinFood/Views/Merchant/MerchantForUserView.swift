import SwiftUI

struct MerchantForUserView: View {
    @StateObject private var merchantViewModel = MerchantViewModel()
    @StateObject private var shopViewModel = ShopViewModel()
      var body: some View {
          NavigationStack{
              ZStack{
                  Color("background")
                  VStack{
                      ForEach(shopViewModel.shoptests, id: \.id) { shopTest in
                          if let foodTests = shopTest.foodTests {
                      HStack() {
                          AsyncImage(url: URL(string: shopTest.image ?? "")) { phase in
                              switch phase {
                              case .empty:
                                  // Placeholder or loading view if needed
                                  Text("Loading...")
                              case .success(let image):
                                  image
                                      .resizable() // Make the image resizable
                                      .aspectRatio(contentMode: .fit)
                                      .frame(width:90)
                              case .failure:
                                  // Handle error if image fails to load
                                  Text("Image loading failed")
                              @unknown default:
                                  // Handle unknown cases or provide a fallback view
                                  Text("Unknown state")
                              }
                          }
                              .frame(width: 75,height: 75)
                          VStack(alignment: .leading){Text(shopTest.storename ?? "")
                                  .fontWeight(.bold)
                              Text(shopTest.address ?? "")
                                  .fontWeight(.bold)
                          }
                          Spacer()
                         
                      }
                      .frame(maxWidth: 350)
                      .padding(.bottom)
                      HStack{
                          Text("Food")
                              .fontWeight(.bold)
                          Spacer()
                      }
                      .frame(height: 50)
                      .frame(maxWidth: 350)
                     
                        
                              ForEach(foodTests) { foodTest in
                                  HStack{
                                      AsyncImage(url: URL(string: foodTest.image ?? "")) { phase in
                                          switch phase {
                                          case .empty:
                                              // Placeholder or loading view if needed
                                              Text("Loading...")
                                          case .success(let image):
                                              image
                                                  .resizable() // Make the image resizable
                                                  .aspectRatio(contentMode: .fit)
                                                  .frame(width:90)
                                          case .failure:
                                              // Handle error if image fails to load
                                              Text("Image loading failed")
                                          @unknown default:
                                              // Handle unknown cases or provide a fallback view
                                              Text("Unknown state")
                                          }
                                      }
                                      .frame(width: 100, height: 100)
                                      VStack(alignment: .leading){
                                          Text(foodTest.foodname ?? "")
                                              .font(.system(size:20))
                                          Text(foodTest.description ?? "")
                                              .font(.system(size:12))
                                          
                                      }
                                      Spacer()
                                      VStack(alignment: .trailing){
                                          Text(foodTest.price ?? "")
                                              .fontWeight(.bold)
                                              .font(.system(size:20))
                                          Text(foodTest.category ?? "")
                                              .font(.system(size:12))
                                      }
                                  }
                                  .frame(height : 80)
                                  .frame(maxWidth: 350)
                                  Divider()
                                      .frame(height: 1)
                                      .background(Color("components"))
                                      .frame(maxWidth: 350)
                              }
                          }
//                          HStack{
//                              AsyncImage(url: URL(string: merchant.image ?? "")) { phase in
//                                  switch phase {
//                                  case .empty:
//                                      // Placeholder or loading view if needed
//                                      Text("Loading...")
//                                  case .success(let image):
//                                      image
//                                          .resizable() // Make the image resizable
//                                          .aspectRatio(contentMode: .fit)
//                                          .frame(width:90)
//                                  case .failure:
//                                      // Handle error if image fails to load
//                                      Text("Image loading failed")
//                                  @unknown default:
//                                      // Handle unknown cases or provide a fallback view
//                                      Text("Unknown state")
//                                  }
//                              }
//                              .frame(width: 100, height: 100)
//                              VStack(alignment: .leading){
//                                  Text(merchant.foodname ?? "")
//                                      .font(.system(size:20))
//                                  Text(merchant.description ?? "")
//                                      .font(.system(size:12))
//
//                              }
//                              Spacer()
//                              VStack(alignment: .trailing){
//                                  Text(merchant.price ?? "")
//                                      .fontWeight(.bold)
//                                      .font(.system(size:20))
//                                  Text(merchant.category ?? "")
//                                      .font(.system(size:12))
//                              }
//                          }
//                          .frame(height : 80)
//                          .frame(maxWidth: 350)
//                          Divider()
//                           .frame(height: 1)
//                           .background(Color("components"))
//                           .frame(maxWidth: 350)
                        
                          
                      }
                  }
              }
              .foregroundStyle(Color("text"))
              .ignoresSafeArea(.all)
             
          }
          .navigationBarBackButtonHidden(true)
         

      }
}

struct MerchantForUserView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantForUserView()
    }
}
