//
//  ResultsView.swift
//  HotdogNotHotdog
//
//  Created by SchwiftyUI on 8/14/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var cameraState: CameraState
    
    var body: some View {
        VStack {
            if cameraState.showResult {
                if cameraState.isHotdog {
                    Image("Hotdog")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .transition(AnyTransition.move(edge: .top))
                } else {
                    Image("NotHotdog")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .transition(AnyTransition.move(edge: .top))
                }
            }
            Spacer()
        }
    }
}

#if DEBUG
struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let cameraState = CameraState()
        cameraState.showResult = true
        return ResultsView(cameraState: cameraState)
    }
}
#endif
