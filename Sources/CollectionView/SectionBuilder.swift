//
//  File.swift
//  
//
//  Created by Giacomo on 06/12/21.
//

import Foundation

@resultBuilder
public struct CVSectionBuilder {
    
    static func buildArray(_ components: [[CVSection]]) -> [CVSection] {
        return components.reduce([], +)
    }

    static func buildBlock(_ components: [CVSection]...) -> [CVSection] {
        return components.reduce([], +)
    }
    
    static func buildExpression(_ expression: CVSection) -> [CVSection] {
        return [expression]
    }
    
}
