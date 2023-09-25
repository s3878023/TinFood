/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Duc Dai  ID: s3878023
  Created  date: 17/09/2023.
  Last modified: 25/09/2023
  Acknowledgement:
    RMIT Lecture Slides https://rmit.instructure.com/courses/121597
    OpenChatAI: https://chat.openai.com/
    Github: https://github.com/s3878023/TinFood/tree/dev
    SFSymbols
    StackOverFlow: https://stackoverflow.com/
*/

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
            .foregroundColor(Color("button"))
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



