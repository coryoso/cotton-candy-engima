//
//  ARModel.swift
//  CandyScanner
//
//  Created by Cornelius Carl on 30.06.23.
//

import Foundation
import RealityKit
import ARKit

extension simd_float4x4 {
    var position: SIMD3<Float> {
        return SIMD3<Float>(columns.3.x, columns.3.y, columns.3.z)
    }
}

struct ARModel {
    private(set) var arView: ARView
    private let robot: Entity
    
    init() {
        arView = ARView()
        
        arView.environment.sceneUnderstanding.options = []
        
        // Turn on occlusion from the scene reconstruction's mesh.
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        
        // Turn on physics for the scene reconstruction's mesh.
        arView.environment.sceneUnderstanding.options.insert(.physics)
        
        // Display a debug visualization of the mesh.
        arView.debugOptions.insert(.showSceneUnderstanding)
        
        // For performance, disable render options that are not required for this app.
        arView.renderOptions = [.disablePersonOcclusion, .disableDepthOfField, .disableMotionBlur]
        
        // Manually configure what kind of AR session to run since
        // ARView on its own does not turn on mesh classification.
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification
        
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
        
        robot = try! Entity.load(named: "robot.usdc")
        robot.scale = SIMD3(0.001, 0.001, 0.001)
    }
    
    mutating func raycast(location:CGPoint) {
        guard let query = arView.makeRaycastQuery(from: location, allowing: .estimatedPlane, alignment: .any) else {
            return
        }
        
        guard let result = arView.session.raycast(query).first else {
            return
        }
        
//        let resultAnchor = AnchorEntity(world: result.worldTransform)
//        resultAnchor.addChild(sphere(radius: 0.01, color: .lightGray))
//        arView.scene.addAnchor(resultAnchor)
        
        let rayDirection = normalize(result.worldTransform.position - self.arView.cameraTransform.translation)
        let positionInWorldCoordinates = result.worldTransform.position - (rayDirection * 0.1)
        
        var resultWithCameraOrientation = self.arView.cameraTransform
        resultWithCameraOrientation.translation = positionInWorldCoordinates
        let resultAnchor = AnchorEntity(world: result.worldTransform)
        resultAnchor.addChild(robot)
        arView.scene.addAnchor(resultAnchor)
        
        print(result)
    }
    
    func sphere(radius: Float, color: UIColor) -> ModelEntity {
        let sphere = ModelEntity(mesh: .generateSphere(radius: radius), materials: [SimpleMaterial(color: color, isMetallic: false)])
        // Move sphere up by half its diameter so that it does not intersect with the mesh
        sphere.position.y = radius
        return sphere
    }
}
