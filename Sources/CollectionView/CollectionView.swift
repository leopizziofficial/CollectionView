//
//  CollectionView.swift
//  iOS
//
//  Created by Giacomo Leopizzi on 03/12/21.
//  Copyright © 2021 Leopizzi. All rights reserved.
//

import UIKit
import SwiftUI

/// The collection view.
public struct CollectionView: UIViewRepresentable {
    
    private let sections: [CVSection]
    private var customize: ((UICollectionView) -> Void)?
    
    /// Create a new collection view.
    /// - Parameter sections: The sections to display.
    public init(@CVSectionBuilder sections: () -> [CVSection]) {
        self.sections = sections()
    }
    
    /// Customize the collection view.
    /// - Parameter function: The function used to perform customizations.
    /// - Returns: The collection view.
    public func customize(_ function: @escaping (UICollectionView) -> Void) -> Self {
        var copy = self
        copy.customize = function
        return copy
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(sections: sections)
    }

    public func makeUIView(context: Context) -> UICollectionView {
        let coordinator = context.coordinator
       
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [unowned coordinator] section, environment in
            return coordinator.layout(section: section, environment: environment)
        })
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = nil
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.reuseIdentifier)
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionReusableView.reuseIdentifier)
        collectionView.dataSource = coordinator
        return collectionView
    }

    public func updateUIView(_ uiView: UICollectionView, context: Context) {
        context.coordinator.update(for: sections)
        self.customize?(uiView)
        // TODO: Move to DiffableDataSource
        uiView.reloadData()
    }
    
}
