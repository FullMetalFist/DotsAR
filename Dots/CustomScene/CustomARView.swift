//
//  CustomARView.swift
//  Dots
//
//  Created by Michael Vilabrera on 10/18/22.
//

import ARKit
import RealityKit
import SwiftUI
import Combine


class CustomARView: ARView {
    
    private var cancellables: Set<AnyCancellable> = []
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError()
    }
    
    convenience required init() {
        self.init(frame: UIScreen.main.bounds)
        
        subscribeToActionStream()
    }
    
    func configurationExamples() {
        // tracks device relative to its environment
        let config = ARWorldTrackingConfiguration()
        session.run(config)
        
        // not supported in all regions
        let _ = ARGeoTrackingConfiguration()
        
        // track faces in scene
        let _ = ARFaceTrackingConfiguration()
        
        // track bodies in scene
        let _ = ARBodyTrackingConfiguration()
    }
    
    func anchorExamples() {
        // attach anchors at specific coordinates in the iPhone-centered coordinate system
        let coordAnchor = AnchorEntity(world: .zero)
        
        // attach anchors to detected planes (this works best on devices with a LIDAR sensor
        let _ = AnchorEntity(plane: .horizontal)
        let _ = AnchorEntity(plane: .vertical)
        
        // attach anchors to tracked body parts such as the face
        let _ = AnchorEntity(.face)
        
        // attach anchors to tracked images, markers or visual codes
        let _ = AnchorEntity(.image(group: "group", name: "name"))
        
        scene.addAnchor(coordAnchor)
    }
    
    func entityExamples () {
        // load an entity from a usdz file
        let _ = try? Entity.load(named: "usdzFileName")
        
        // load an entity from a reality file
        let _ = try? Entity.load(named: "realityFileName")
        
        // generate an entity from code
        let box = MeshResource.generateBox(size: 1)
        let entity = ModelEntity(mesh: box)
        
        // add entity to anchor , so it can be placed in a scene
        let anchor = AnchorEntity()
        anchor.addChild(entity)
    }
    
    func subscribeToActionStream() {
        ARManager.shared.actionStream.sink { [weak self] action in
            switch action {
            case .placeBlock(let color):
                self?.placeBlock(of: color)
            case .removeAllAnchors:
                self?.scene.anchors.removeAll()
            }
        }.store(in: &cancellables)

    }
    
    func placeBlock(of color: Color) {
        let block = MeshResource.generateBox(size: 1)
        let material = SimpleMaterial(color: UIColor(color), isMetallic: true)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        
        scene.addAnchor(anchor)
    }
}
