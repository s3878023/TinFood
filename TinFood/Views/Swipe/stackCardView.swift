////
////  stackCardView.swift
////  TinFood
////
////  Created by Đại Đức on 13/09/2023.
////
//
import SwiftUI

struct stackCardView: View {
    @EnvironmentObject var homeData: homeViewModel
    var shop: Shop
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false


    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            let index = CGFloat(homeData.getIndex(shop: shop))
            let topOffset = (index <= 2 ? index: 2) * 15

            ZStack{
                Image(shop.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(15)
                    .offset(y: -topOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0:1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in out = true

                })
                .onChanged({value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    let checkingStatus = (translation > 0 ? translation : -translation)

                    withAnimation{
                        if checkingStatus > (width / 2){
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeActions()
                            if translation > 0 {
                                rightSwipe()
                            }else{
                                leftSwipe()
                            }
                        }else{
                            offset = .zero
                        }
                    }

                })
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) {
            data in
            guard let info = data.userInfo else{
                return
            }
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            if shop.id == id{
                offset = (rightSwipe ? width : -width) * 2
                endSwipeActions()
                if rightSwipe {
                    self.rightSwipe()
                }else{
                    leftSwipe()
                }
            }
        }
    }

    func getRotation(angle: Double)->Double{
        let rotation = (offset / (getRect().width - 50)) * angle

        return rotation
    }

    func endSwipeActions(){
        withAnimation(.none){endSwipe = true}

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            if let _ = homeData.displaying_shops?.first{
               let _ = withAnimation{
                    homeData.displaying_shops?.removeFirst()
                }
            }
        }
    }
    func leftSwipe(){
        homeData.dislikedShops.append(shop.name)
        //adding more function if wanted here
        print("left swipe")
    }

    func rightSwipe(){
        homeData.likedShops.append(shop.name)

        print("right swipe")
    }
}

struct stackCardView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
