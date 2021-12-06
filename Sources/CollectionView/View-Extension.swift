//
//  File.swift
//  
//
//  Created by Giacomo on 06/12/21.
//

import SwiftUI
import UIKit

extension View {
    
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
    func uiKit() -> UIView {
        var view: UIView!
        autoreleasepool(invoking: {
            view = UIHostingController(rootView: self).view
        })
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        return view
    }
    
}
