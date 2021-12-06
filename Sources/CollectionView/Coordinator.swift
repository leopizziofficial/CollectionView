//
//  File.swift
//  
//
//  Created by Giacomo on 06/12/21.
//

import UIKit
import SwiftUI

extension CollectionView {
    
    final public class Coordinator : NSObject, UICollectionViewDataSource {
        
        private var sections: [CVSection]
        
        init(sections: [CVSection]) {
            self.sections = sections
        }
        
        func layout(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            let section = sections[section]
            return section.getLayout(for: environment)
        }
        
        func update(for sections: [CVSection]) {
            self.sections = sections
        }
        
        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return sections.count
        }
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return sections[section].elementsCount
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
            let section = sections[indexPath.section]
            let view = section.makeCell(for: indexPath.row)
            cell.update(for: view)
            return cell
        }
        
        public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let section = sections[indexPath.section]
            let content: AnyView
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                content = section.header()
            default:
                content = section.footer()
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionReusableView.reuseIdentifier, for: indexPath) as! CollectionReusableView
            view.update(for: content)
            return view
        }
        
    }
    
}
