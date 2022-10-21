//
//  ARManager.swift
//  Dots
//
//  Created by Michael Vilabrera on 10/20/22.
//

import Combine

final class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
