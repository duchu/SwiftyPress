//
//  Post.swift
//  SwiftyPress
//
//  Created by Basem Emara on 2018-05-30.
//

import Foundation

public struct Post: PostType, Decodable {
    public let id: Int
    public let slug: String
    public let type: String
    public let title: String
    public let content: String
    public let excerpt: String
    public let link: String
    public let commentCount: Int
    public let authorID: Int
    public let mediaID: Int?
    public let categories: [Int]
    public let tags: [Int]
    public let createdAt: Date
    public let modifiedAt: Date
}

// MARK: - For JSON decoding

private extension Post {
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case type
        case title
        case content
        case excerpt
        case link
        case commentCount = "comment_count"
        case authorID = "author"
        case mediaID = "featured_media"
        case categories
        case tags
        case createdAt = "created"
        case modifiedAt = "modified"
    }
}

extension Post {
    
    /// For converting to one type to another.
    ///
    /// - Parameter object: An instance of post type.
    init(from object: PostType) {
        self.init(
            id: object.id,
            slug: object.slug,
            type: object.type,
            title: object.title,
            content: object.content,
            excerpt: object.excerpt,
            link: object.link,
            commentCount: object.commentCount,
            authorID: object.authorID,
            mediaID: object.mediaID,
            categories: object.categories,
            tags: object.tags,
            createdAt: object.createdAt,
            modifiedAt: object.modifiedAt
        )
    }
    
    /// For converting to one type to another.
    ///
    /// - Parameter object: An instance of post type.
    init?(from object: PostType?) {
        guard let object = object else { return nil }
        self.init(from: object)
    }
}
