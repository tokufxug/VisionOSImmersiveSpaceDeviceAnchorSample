//
//  AppleVisionPro.swift
//  VisionOSImmersiveSpaceDeviceAnchorSample
//
//  Created by Sadao Tokuyama on 1/18/24.
//
import Observation
import ARKit

@Observable
class AppleVisionPro {
    
    let arKitSession = ARKitSession()
    let worldTrackingProvider = WorldTrackingProvider()
    
    func run() async {
        Task {
            try await arKitSession.run([worldTrackingProvider])
        }
    }
    
    func getTransform() async -> simd_float4x4? {
        if let anchor = worldTrackingProvider.queryDeviceAnchor(atTimestamp: 1) {
            return anchor.originFromAnchorTransform
        }
        return nil
    }
}

