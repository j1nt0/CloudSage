//
//  CameraView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//
import SwiftUI
import UIKit
import AVFoundation

struct CameraView: View {
    @State private var isImagePickerPresented = false
    @State private var image: UIImage?
    @Binding var path: NavigationPath
    var cvm: CameraViewModel
    var cloudData: CloudData
    
    var body: some View {
        VStack {
            ImagePicker(isImagePickerPresented: $isImagePickerPresented, image: $image)
                .ignoresSafeArea()
        }
        .onChange(of: image) { newImage in
            if newImage != nil {
                path.append(newImage!)
                cvm.selectedImage = image?.toSquareImage()
                cvm.createSticker()
            }
        }
        .navigationDestination(for: UIImage.self) { image in
            TrackResultView(cvm: cvm, cloudData: cloudData, path: $path)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isImagePickerPresented: Bool
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.isImagePickerPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isImagePickerPresented = false
        }
    }
}

