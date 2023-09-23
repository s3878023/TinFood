//////
//////  stackCardView.swift
//////  TinFood
//////
//////  Created by Đại Đức on 13/09/2023.
//////
////
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//
//struct stackCardView: View {
//    @EnvironmentObject var homeData: homeViewModel
//    @ObservedObject var loginViewModel: LoginViewModel
//
//    var shop: Shop
//    @State var offset: CGFloat = 0
//    @GestureState var isDragging: Bool = false
//    @State var endSwipe: Bool = false
//
//
//    var body: some View {
//        GeometryReader{proxy in
//            let size = proxy.size
//            let index = CGFloat(homeData.getIndex(shop: shop))
//            let topOffset = (index <= 2 ? index: 2) * 15
//
//            ZStack{
//                AsyncImage(url: URL(string: shop.profilePic ?? "")) { image in
//                    image.resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: size.width - topOffset, height: size.height)
//                        .cornerRadius(15)
//                        .offset(y: -topOffset)
//                } placeholder: {
//                    ProgressView()
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//        }
//        .offset(x: offset)
//        .rotationEffect(.init(degrees: getRotation(angle: 8)))
//        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0:1))
//        .gesture(
//            DragGesture()
//                .updating($isDragging, body: { value, out, _ in out = true
//
//                })
//                .onChanged({value in
//                    let translation = value.translation.width
//                    offset = (isDragging ? translation : .zero)
//                })
//                .onEnded({value in
//                    let width = getRect().width - 50
//                    let translation = value.translation.width
//                    let checkingStatus = (translation > 0 ? translation : -translation)
//
//                    withAnimation{
//                        if checkingStatus > (width / 2){
//                            offset = (translation > 0 ? width : -width) * 2
//                            endSwipeActions()
//                            if translation > 0 {
//                                rightSwipe()
//                            }else{
//                                leftSwipe()
//                            }
//                        }else{
//                            offset = .zero
//                        }
//                    }
//
//                })
//        )
//        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) {
//            data in
//            guard let info = data.userInfo else{
//                return
//            }
//            let id = info["id"] as? String ?? ""
//            let rightSwipe = info["rightSwipe"] as? Bool ?? false
//            let width = getRect().width - 50
//            if shop.id == id{
//                offset = (rightSwipe ? width : -width) * 2
//                endSwipeActions()
//                if rightSwipe {
//                    self.rightSwipe()
//                }else{
//                    leftSwipe()
//                }
//            }
//        }
//    }
//
//    func getRotation(angle: Double)->Double{
//        let rotation = (offset / (getRect().width - 50)) * angle
//
//        return rotation
//    }
//
//    func endSwipeActions(){
//        withAnimation(.none){endSwipe = true}
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//            if let _ = homeData.displaying_shops?.first{
//               let _ = withAnimation{
//                    homeData.displaying_shops?.removeFirst()
//                }
//            }
//        }
//    }
//    func leftSwipe(){
//        let documentID = loginViewModel.userUUID
//
//        homeData.likedShops.append(shop.name)
//        let collectionName = "User"
//        let db = Firestore.firestore()
//                db.collection(collectionName).document(documentID).updateData([
//            "blockedShops": FieldValue.arrayUnion([shop.name])
//        ]) { error in
//            if let error = error {
//                print("Error updating Firestore: \(error.localizedDescription)")
//            } else {
//                print("Shop name added to Firestore array successfully")
//            }
//        }
//
//        print("right swipe")
//    }
//
//    func rightSwipe() {
//        let documentID = loginViewModel.userUUID
//
//        homeData.likedShops.append(shop.name)
//        let collectionName = "User"
//        let db = Firestore.firestore()
//                db.collection(collectionName).document(documentID).updateData([
//            "likedShops": FieldValue.arrayUnion([shop.name])
//        ]) { error in
//            if let error = error {
//                print("Error updating Firestore: \(error.localizedDescription)")
//            } else {
//                print("Shop name added to Firestore array successfully")
//            }
//        }
//
//        print("right swipe")
//    }
//
//
//}
//
//struct stackCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
//
//extension View {
//    func getRect()->CGRect{
//        return UIScreen.main.bounds
//    }
//}
import SwiftUI
import Firebase
import FirebaseFirestore

struct stackCardView: View {
    @EnvironmentObject var homeData: homeViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    
    var shop: Shop
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    @State var isShopBlocked: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(homeData.getIndex(shop: shop))
            let topOffset = (index <= 2 ? index : 2) * 15
            
            if !isShopBlocked {
                ZStack {
                    AsyncImage(url: URL(string: shop.image )) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width - topOffset, height: size.height)
                            .cornerRadius(15)
                            .offset(y: -topOffset)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .offset(x: offset)
                .rotationEffect(.init(degrees: getRotation(angle: 8)))
                .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
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
                }))
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
        }
        .onAppear {
            checkIfShopIsBlocked()
        }
    }
    
    func getRotation(angle: Double)->Double{
        let rotation = (offset / (getRect().width - 50)) * angle
        return rotation
    }
    
    func checkIfShopIsBlocked() {
            let documentID = loginViewModel.userUUID
            let collectionName = "User"
            let db = Firestore.firestore()
            
            db.collection(collectionName).document(documentID).getDocument { snapshot, error in
                if let error = error {
                    print("Error fetching Firestore document: \(error.localizedDescription)")
                } else if let data = snapshot?.data(),
                          let blockedShops = data["blockedShops"] as? [String],
                          let likedShops = data["likedShops"] as? [String],
                          (blockedShops.contains(shop.storename) || likedShops.contains(shop.storename)) {
                    isShopBlocked = true // Shop is blocked or liked
                } else {
                    isShopBlocked = false // Shop is neither blocked nor liked
                }
            }
        }
//    func checkIfShopIsBlocked() {
//        let documentID = loginViewModel.userUUID
//        let collectionName = "User"
//        let db = Firestore.firestore()
//
//        db.collection(collectionName).document(documentID).getDocument { snapshot, error in
//            if let error = error {
//                print("Error fetching Firestore document: \(error.localizedDescription)")
//            } else if let data = snapshot?.data(),
//                      let blockedShops = data["blockedShops"] as? [String],
//                      blockedShops.contains(shop.name) {
//                isShopBlocked = true // Shop is blocked
//            } else {
//                isShopBlocked = false // Shop is not blocked
//            }
//        }
//    }

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
        let documentID = loginViewModel.userUUID
        let collectionName = "User"
        let db = Firestore.firestore()
        db.collection(collectionName).document(documentID).updateData([
            "blockedShops": FieldValue.arrayUnion([shop.storename])
        ]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            } else {
                print("Shop name added to Firestore array successfully")
            }
        }
        
        print("leftSwipe swipe")
    }
    
    func rightSwipe() {
        let documentID = loginViewModel.userUUID
        let collectionName = "User"
        let db = Firestore.firestore()
        db.collection(collectionName).document(documentID).updateData([
            "likedShops": FieldValue.arrayUnion([shop.storename])
        ]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            } else {
                print("Shop name added to Firestore array successfully")
            }
        }
        
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


