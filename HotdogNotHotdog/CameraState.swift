//
//  CameraState.swift
//  HotdogNotHotdog
//
//  Created by SchwiftyUI on 8/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI
import Combine
import CoreML
import Vision
import ImageIO

class CameraState: ObservableObject {
    var objectWillChange = ObservableObjectPublisher()
    
    var isTakingPhoto = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var hotdogPhoto: UIImage? = nil {
       willSet {
           objectWillChange.send()
       }
        didSet {
            if hotdogPhoto != nil {
                showResult = false
                updateClassifications(image: hotdogPhoto!)
            }
        }
   }
    
    var isHotdog = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var showResult = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            if classifications.isEmpty {
                withAnimation {
                    self.showResult = true
                    self.isHotdog = false
                }
            } else {
                let identifier = classifications[0].identifier
                withAnimation {
                    self.isHotdog = identifier.contains("hotdog")
                    self.showResult = true
                }
            }
        }
    }
    
    lazy var classificationRequest: VNRequest = {
        do {
            let model = try VNCoreMLModel(for: Resnet50().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            return request
        } catch {
            fatalError("Error importing model")
        }
    }()
    
    func updateClassifications(image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async
        {
            do {
                let handler = VNImageRequestHandler(ciImage: CIImage(image: image)!)
                try handler.perform([self.classificationRequest])
            } catch {
                fatalError("Error performing classification")
            }
        }
    }
}
