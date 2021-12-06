//
//  File.swift
//  
//
//  Created by Giacomo on 06/12/21.
//

import SwiftUI

/// A section for the collection view.
public struct CVSection {
    
    // MARK: - Properties
    
    private var layout: ((NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection)?
    private let content: [AnyHashable]?
    private let cell: (AnyHashable) -> AnyView
    
    let header: () -> AnyView
    let footer: () -> AnyView
    
    // MARK: - Init
    
    public init<Cell: View, Header: View, Footer: View, T: Hashable>(content: [T]?, @ViewBuilder header: @escaping () -> Header, @ViewBuilder footer: @escaping () -> Footer, @ViewBuilder cell: @escaping (T) -> Cell) {
        self.content = content
        self.cell = { cell($0 as! T).eraseToAnyView() }
        self.header = { header().eraseToAnyView() }
        self.footer = { footer().eraseToAnyView() }
    }
    
    public init<Cell: View, Header: View, T: Hashable>(content: [T]?, @ViewBuilder header: @escaping () -> Header, @ViewBuilder cell: @escaping (T) -> Cell) {
        self.init(content: content, header: header, footer: { EmptyView().eraseToAnyView() }, cell: cell)
    }
    
    public init<Cell: View, Footer: View, T: Hashable>(content: [T]?, @ViewBuilder footer: @escaping () -> Footer, @ViewBuilder cell: @escaping (T) -> Cell) {
        self.init(content: content, header: { EmptyView().eraseToAnyView() }, footer: footer, cell: cell)
    }
    
    public init<Cell: View, T: Hashable>(content: [T]?, @ViewBuilder cell: @escaping (T) -> Cell) {
        let view =  { EmptyView().eraseToAnyView() }
        self.init(content: content, header: view, footer: view, cell: cell)
    }
    
    // MARK: - Methods
    
    /// Set a custom layout for the section.
    /// - Parameter builder: A function that build the layout for the current section.
    /// - Returns: The section.
    public func layout(_ builder: @escaping (NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection) -> Self {
        var copy = self
        copy.layout = builder
        return copy
    }
    
}

extension CVSection: Hashable {
    
    static public func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.content == rhs.content
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
    
}

extension CVSection {
    
    var elementsCount: Int {
        return content?.count ?? 0
    }
    
    func makeCell(for index: Int) -> AnyView {
        let element = self.content![index]
        return cell(element)
    }
    
    func getLayout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        if let builder = self.layout {
            return builder(environment)
        }
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        ]
        
        return section
    }
    
}
