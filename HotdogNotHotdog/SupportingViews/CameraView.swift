//
//  CameraView.swift
//  HotdogNotHotdog
//
//  Created by SchwiftyUI on 8/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var cameraState: CameraState
    var coordinator: Coordinator!

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        return UIImagePickerController()
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraView>) {
        uiViewController.mediaTypes = ["public.image"]
        uiViewController.delegate = context.coordinator
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            uiViewController.sourceType = .camera
        } else {
            uiViewController.sourceType = .photoLibrary
        }
    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        
        init(_ cameraView: CameraView) {
            parent = cameraView
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.cameraState.hotdogPhoto = nil
            withAnimation {
                parent.cameraState.isTakingPhoto = false
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.cameraState.hotdogPhoto = image
            } else {
                parent.cameraState.hotdogPhoto = nil
            }
            withAnimation {
                parent.cameraState.isTakingPhoto = false
            }
        }
    }
}

#if DEBUG
struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(cameraState: CameraState())
    }
}
#endif
