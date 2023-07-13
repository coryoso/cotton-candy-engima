//
//  ARViewModel.swift
//  CandyScanner
//
//  Created by Cornelius Carl on 30.06.23.
//

import Foundation
import RealityKit

class ARViewModel: ObservableObject {
    @Published private var model: ARModel = ARModel()
    
    var arView: ARView {
        return model.arView
    }
    
    func raycast(location:CGPoint){
        return model.raycast(location: location)
    }
}
