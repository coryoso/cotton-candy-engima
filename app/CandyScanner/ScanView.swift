//
//  ContentView.swift
//  CandyScanner
//
//  Created by Cornelius Carl on 26.06.23.
//

import SwiftUI
import ARKit
import RealityKit

struct ScanView: View {
    var arViewModel: ARViewModel = ARViewModel()
    @State private var showSheet = true
    
    var body: some View {
        ZStack {
            ProgressView().progressViewStyle(.circular)
            
            ARViewContainer(arViewModel: arViewModel)
                .ignoresSafeArea()
                .onTapGesture(coordinateSpace: .global) { location in
                    arViewModel.raycast(location: location)
                }
            
        }.overlay(
            HStack(alignment: .center) {
                Button(action: {
                    showSheet = true
                }, label: {
                    Label("info", systemImage: "info")
                })
            }.sheet(isPresented: $showSheet) {
                IntroView()
                    .presentationDetents([.medium, .large])
            }, alignment: .bottom).background(.red)
    }
}
