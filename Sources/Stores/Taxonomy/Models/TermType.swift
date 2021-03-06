//
//  TermType.swift
//  SwiftPress
//
//  Created by Basem Emara on 2018-05-26.
//

public protocol TermType: Identifiable {
    var parentID: Int { get }
    var slug: String { get }
    var name: String { get }
    var taxonomy: Taxonomy { get }
    var count: Int { get }
}
