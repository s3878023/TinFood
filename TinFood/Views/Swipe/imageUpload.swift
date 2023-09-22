import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ImageUploadView: View {
    @State private var image: Image?
    @State private var isImagePickerPresented = false
    @State private var imageURL: URL?
    @State private var isLoading = false
    @State private var uiImage: UIImage? = nil

    var body: some View {
        VStack {
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
                            // Display the uploaded image from the URL using AsyncImage
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            }placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 200)
                        }
        }
        .padding()
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

//    func uploadImage() {
//        isLoading = true
//
//        // Generate a unique filename for the image
//        let imageName = UUID().uuidString
//
//        // Reference to Firebase Storage
//        let storageRef = Storage.storage().reference().child("\(imageName)")
//
//        // Convert the UIImage to Data
//        guard let imageData = uiImage?.jpegData(compressionQuality: 0.8) else {
//            isLoading = false
//            return
//        }
//
//        // Upload image data to Firebase Storage
//        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
//            if let error = error {
//                print("Error uploading image: \(error.localizedDescription)")
//                isLoading = false
//            } else {
//                // Get the download URL for the uploaded image
//                storageRef.downloadURL { (url, error) in
//                    isLoading = false
//                    if let error = error {
//                        print("Error getting download URL: \(error.localizedDescription)")
//                    } else if let url = url {
//                        // Set the imageURL and display it
//                        imageURL = url
//                    }
//                }
//            }
//        }
//    }
}

struct ImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?

        init(image: Binding<UIImage?>) {
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image)
    }
}
