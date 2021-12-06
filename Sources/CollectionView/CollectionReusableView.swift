//
//  File.swift
//  
//
//  Created by Giacomo on 06/12/21.
//

import UIKit
import SwiftUI

final class CollectionReusableView : UICollectionReusableView {
    
    static var reuseIdentifier: String {
        "CollectionReusableView"
    }
    
    private var currentContent: UIView?
    
    func update<Content: View>(for content: Content) {
        let view = content.uiKit()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        currentContent?.removeFromSuperview()
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        self.currentContent = view
    }
    
}
