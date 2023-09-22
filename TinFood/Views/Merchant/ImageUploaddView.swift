import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ImageUploaddView: View {
    @State private var image: Image?
    @State private var isImagePickerPresented = false
    @State private var imageURL: URL?
    @State private var isLoading = false
    @State private var uiImage: UIImage? = nil
    @EnvironmentObject var shopViewModel: ShopViewModel
    @Binding var newFood: FoodTest
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil

    var body: some View {
            NavigationView{
                Form {
                    if image != nil {
                        image!
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    } else {
                        Text("No image selected")
                    }
                    
                    Button("Select Image") {
                        isImagePickerPresented.toggle()
                    }
                    .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
                        ImagePicker(image: $uiImage)
                    }
                    
                    if isLoading {
                        ProgressView()
                    } else {
                        Button("Upload Image") {
                            uploadImage()
                        }
                        .disabled(uiImage == nil)
                    }
                    if let imageURL = imageURL {
                        // Display the image URL as text
                        Text("Image URL: \(imageURL.absoluteString)")
                            .padding()
                        
                        // Provide a button to copy the URL to the clipboard
                        Button("Copy URL") {
                            // Copy the imageURL to the clipboard
                            UIPasteboard.general.string = imageURL.absoluteString
                        }
                        .padding()
                    }
                    Section(header: Text("Food Details")) {
                        TextField("Food Name", text: Binding<String>(
                            get: { newFood.foodname ?? "" },
                            set: { newValue in newFood.foodname = newValue }
                        ))
                        TextField("Price", text: Binding<String>(
                            get: { newFood.price ?? "" },
                            set: { newValue in newFood.price = newValue }
                        ))
                        TextField("Description", text: Binding<String>(
                            get: { newFood.description ?? "" },
                            set: { newValue in newFood.description = newValue }
                        ))
                        TextField("Image URL", text: Binding<String>(
                            get: { newFood.image ?? "" },
                            set: { newValue in newFood.image = newValue }
                        ))
                        TextField("Category", text: Binding<String>(
                            get: { newFood.category ?? "" },
                            set: { newValue in newFood.category = newValue }
                        ))
                    }

                    Section {
                        Button("Add Food") {
                            // Call the function in ShopViewModel to add the food
                            shopViewModel.addFood(newFood: newFood)
                        }
                    }
                }
                
            }

    }

    func loadImage() {
        if let uiImage = uiImage {
            image = Image(uiImage: uiImage)
        }
    }
    func uploadImage() {
        isLoading = true

        // Generate a unique filename for the image
        let imageName = UUID().uuidString

        // Reference to Firebase Storage
        let storageRef = Storage.storage().reference().child("images/\(imageName)")

        // Convert the UIImage to Data
        guard let imageData = uiImage?.jpegData(compressionQuality: 0.8) else {
            isLoading = false
            return
        }

        // Upload image data to Firebase Storage
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                isLoading = false
            } else {
                // Get the download URL for the uploaded image
                storageRef.downloadURL { (url, error) in
                    isLoading = false
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                    } else if let url = url {
                        // Set the imageURL and display it
                        imageURL = url
                        print("Image URL: \(url.absoluteString)") // Print the URL to the console
                    }
                }
            }
        }
    }
   
}

struct ImageUploaddView_Previews: PreviewProvider {
    @State static var newFood = FoodTest()
    static var previews: some View {
        ImageUploaddView(newFood: $newFood)
    }
}
