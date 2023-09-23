import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ImageUploadView: View {
    @State private var image: Image?
    @State private var isImagePickerPresented = false
    @Binding var imageURL: URL?
    @State private var isLoading = false
    @State private var uiImage: UIImage? = nil
    @State private var uploadStatusText = "Upload Image"

    var body: some View {
        VStack {
            ZStack {
            if image != nil {
                image!
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Button("        ") {
                            isImagePickerPresented.toggle()
                        }
                        .foregroundColor(.white)
                        .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
                            ImagePicker(image: $uiImage)
                        }
                    }
                
            } else {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                Button("Select") {
                    isImagePickerPresented.toggle()
                }
                .foregroundColor(.white)
                .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
                    ImagePicker(image: $uiImage)
                }
            }
        }

        if isLoading {
            ProgressView()
        } else {
            Button(uploadStatusText) {
                uploadImage()
            }
            .disabled(uiImage == nil)
        }
        if let imageURL = imageURL {
//            // Display the image URL as text
//            Text("Image URL: \(imageURL.absoluteString)")
//                .padding()
//
//            // Provide a button to copy the URL to the clipboard
//            Button("Copy URL") {
//                // Copy the imageURL to the clipboard
//                UIPasteboard.general.string = imageURL.absoluteString
//            }
//            .padding()
        }
    }
    .padding()
}

    func loadImage() {
        if let uiImage = uiImage {
            image = Image(uiImage: uiImage)
            uploadImage()
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
                        uploadStatusText = "Uploaded ✅"
                        print("Image URL: \(url.absoluteString)") // Print the URL to the console
                    }
                }
            }
        }
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

//struct ImageUploadView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageUploadView(imageURL: )
//    }
//}

