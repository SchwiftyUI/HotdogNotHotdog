//
//  CameraState.swift
//  HotdogNotHotdog
//
//  Created by SchwiftyUI on 8/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI
import Combine

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
   }
}
