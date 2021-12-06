//
//  File.swift
//  
//
//  Created by Giacomo on 06/12/21.
//

import UIKit
import SwiftUI

final class CollectionViewCell : UICollectionViewCell {
    
    static var reuseIdentifier: String {
        "CollectionViewCell"
    }
    
    private var currentContent: UIView?
    
    func update<Content: View>(for content: Content) {
        let view = content.uiKit()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        currentContent?.removeFromSuperview()
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        self.currentContent = view
    }
    
}
