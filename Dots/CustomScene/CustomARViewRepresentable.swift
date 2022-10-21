//
//  CustomARViewRepresentable.swift
//  Dots
//
//  Created by Michael Vilabrera on 10/18/22.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
