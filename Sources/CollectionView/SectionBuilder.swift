//
//  File.swift
//  
//
//  Created by Giacomo on 06/12/21.
//

import Foundation

@resultBuilder
public struct CVSectionBuilder {
    
    static public func buildArray(_ components: [[CVSection]]) -> [CVSection] {
        return components.reduce([], +)
    }

    static public func buildBlock(_ components: [CVSection]...) -> [CVSection] {
        return components.reduce([], +)
    }
    
    static public func buildExpression(_ expression: CVSection) -> [CVSection] {
        return [expression]
    }
    
}
