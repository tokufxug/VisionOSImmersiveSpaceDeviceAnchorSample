//
//  ImmersiveView.swift
//  VisionOSImmersiveSpaceDeviceAnchorSample
//
//  Created by Sadao Tokuyama on 1/18/24.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    
    private let appleVisionPro = AppleVisionPro()
    private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var entity: Entity?
    
    var body: some View {
        RealityView { content in
            Task {
                await appleVisionPro.run()
            }
            entity = try? await Entity(named: "toy_car")
            guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
            
            let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.1)
            entity!.components.set(iblComponent)
            entity!.components.set(ImageBasedLightReceiverComponent(imageBasedLight: entity!))
       
            content.add(entity!)
        }
        .onReceive(timer) { _ in
            Task {
                let transform = await appleVisionPro.getTransform()
                if entity != nil {
                    let t = Transform(matrix: transform!)
                    entity!.orientation = t.rotation
                    
                    let posX = Float(transform?.columns.3.x ?? 0.0)
                    let posY = Float(transform?.columns.3.y ?? 0.0)
                    let posZ = Float(transform?.columns.3.z ?? 0.0) - 0.5
                    entity!.position = [posX, posY, posZ]
                }
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
