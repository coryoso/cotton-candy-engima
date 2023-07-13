//
//  CustomArView.swift
//  CandyScanner
//
//  Created by Cornelius Carl on 26.06.23.
//

import SwiftUI
import ARKit
import UIKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    var arViewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARView {        
        return arViewModel.arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}
