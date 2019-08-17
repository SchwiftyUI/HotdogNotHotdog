//
//  ContentView.swift
//  HotdogNotHotdog
//
//  Created by SchwiftyUI on 8/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cameraState: CameraState
    
    var body: some View {
        ZStack {
            ImageView(cameraState: cameraState)
            
            ResultsView(cameraState: cameraState)
            
            if cameraState.isTakingPhoto {
                CameraView(cameraState: cameraState)
                    .transition(AnyTransition.move(edge: .trailing))
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cameraState: CameraState())
    }
}
#endif
