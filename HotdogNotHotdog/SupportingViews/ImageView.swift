//
//  ImageView.swift
//  HotdogNotHotdog
//
//  Created by SchwiftyUI on 8/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var cameraState: CameraState
    
    var body: some View {
        ZStack {
            cameraState.hotdogPhoto.map { hotdogPhoto in
                Image(uiImage: hotdogPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack {
                Spacer()
                Button(action: {
                    withAnimation{
                        self.cameraState.isTakingPhoto = true
                    }
                }) {
                    Text("Take Photo")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#if DEBUG
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(cameraState: CameraState())
    }
}
#endif
