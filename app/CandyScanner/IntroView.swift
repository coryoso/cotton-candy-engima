//
//  IntroView.swift
//  CandyScanner
//
//  Created by Cornelius Carl on 26.06.23.
//

import SwiftUI
import SceneKit

struct IntroView: View {
    var body: some View {
        VStack {
            SceneView(scene: scene(), pointOfView: nil, options: [.allowsCameraControl, .autoenablesDefaultLighting], preferredFramesPerSecond: 60, antialiasingMode: .multisampling2X, delegate: nil, technique: nil)
            
            Text("Welcome to CandyCotton")
            
            Button("Start") {
                // hide
            }
        }
    }
    
    func scene() -> SCNScene {
        guard let url = Bundle.main.url(forResource: "robot", withExtension: "usdc") else { fatalError() }
        
        return try! SCNScene(url: url)
    }
}

#Preview {
    IntroView()
}
