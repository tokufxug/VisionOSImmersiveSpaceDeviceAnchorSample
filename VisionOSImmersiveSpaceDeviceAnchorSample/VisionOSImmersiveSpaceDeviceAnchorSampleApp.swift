//
//  VisionOSImmersiveSpaceDeviceAnchorSampleApp.swift
//  VisionOSImmersiveSpaceDeviceAnchorSample
//
//  Created by Sadao Tokuyama on 1/18/24.
//

import SwiftUI

@main
struct VisionOSImmersiveSpaceDeviceAnchorSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
