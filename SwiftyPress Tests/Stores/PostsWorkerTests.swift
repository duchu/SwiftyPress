//
//  SwiftyPress_iOSTests.swift
//  SwiftyPress iOSTests
//
//  Created by Basem Emara on 2018-05-30.
//

import XCTest
import ZamzamKit
@testable import SwiftyPress

class PostsWorkerTests: BaseTestCase, HasDependencies {
    
    private lazy var postsWorker: PostsWorkerType = dependencies.resolveWorker()

}

extension PostsWorkerTests {
    
    func testFetch() {
        let promise = expectation(description: "Posts fetch all promise")
        
        postsWorker.fetch {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch all error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(!value.isEmpty)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

extension PostsWorkerTests {
    
    func testFetchByID() {
        let promise = expectation(description: "Posts fetch by ID promise")
        let id = 5568
        
        postsWorker.fetch(id: id) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by ID error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.post.id == id)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchByIDError() {
        let promise = expectation(description: "Posts fetch by ID error promise")
        let id = 99999
        
        postsWorker.fetch(id: id) {
            defer { promise.fulfill() }
            
            guard case .nonExistent? = $0.error else {
                return XCTFail("Posts fetch by ID error should have failed.")
            }
            
            XCTAssertTrue(true)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

extension PostsWorkerTests {
    
    func testFetchByIDs() {
        let promise = expectation(description: "Posts fetch by IDs promise")
        let ids = [791, 26200]
        
        postsWorker.fetch(ids: Set(ids)) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by IDs error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.map { $0.id }.sorted() == ids)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

extension PostsWorkerTests {
    
    func testFetchBySlug() {
        let promise = expectation(description: "Posts fetch by slug promise")
        let slug = "protocol-oriented-router-in-swift"
        
        postsWorker.fetch(slug: slug) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by slug error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.slug == slug)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

extension PostsWorkerTests {
    
    func testFetchByURL() {
        let promise = expectation(description: "Posts fetch by url promise")
        let url = "http://example.com/swift-delegates-closure-pattern"
        
        postsWorker.fetch(url: url) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by url error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.id == 5568)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchByURL2() {
        let promise = expectation(description: "Posts fetch by url 2 promise")
        let url = "http://example.com/whats-new-ios-BEYond/?abc=123#test"
        
        postsWorker.fetch(url: url) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by url 2 error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.id == 791)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchByURL3() {
        let promise = expectation(description: "Posts fetch by url 3 promise")
        let url = "/protocol-oriented-THEmes-for-ios-apps/?abc=123#test"
        
        postsWorker.fetch(url: url) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by url 3 error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.id == 41373)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchByURL4() {
        let promise = expectation(description: "Posts fetch by url 4 promise")
        let url = "memory-leaKS-resource-management-swift-ios"
        
        postsWorker.fetch(url: url) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by url 4 error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.id == 771)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

extension PostsWorkerTests {
    
    func testFetchByCategories() {
        let promise = expectation(description: "Posts fetch by categories promise")
        let ids: Set = [4, 64]
        
        postsWorker.fetch(byCategoryIDs: ids) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by categories error: \(String(describing: $0.error))")
            }
            
            let expression = value.allSatisfy {
                $0.categories.contains(where: ids.contains)
            }
            
            XCTAssertTrue(expression)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchByTags() {
        let promise = expectation(description: "Posts fetch by tags promise")
        let ids: Set = [52]
        
        postsWorker.fetch(byTagIDs: ids) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by tags error: \(String(describing: $0.error))")
            }
            
            let expression = value.allSatisfy {
                $0.tags.contains(where: ids.contains)
            }
            
            XCTAssertTrue(expression)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchByTerms() {
        let promise = expectation(description: "Posts fetch by terms promise")
        let ids: Set = [56, 58, 77]
        
        postsWorker.fetch(byTermIDs: ids) {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch by terms error: \(String(describing: $0.error))")
            }
            
            let expression = value.allSatisfy {
                ($0.categories + $0.tags).contains(where: ids.contains)
            }
            
            XCTAssertTrue(expression)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

extension PostsWorkerTests {
    
    func testFavorites() {
        let promise = expectation(description: "Posts fetch favorites promise")
        let ids = [5568, 26200]
        
        postsWorker.addFavorite(id: ids[0])
        postsWorker.addFavorite(id: ids[1])
        
        postsWorker.fetchFavorites {
            defer { promise.fulfill() }
            
            guard let value = $0.value, $0.isSuccess else {
                return XCTFail("Posts fetch favorites error: \(String(describing: $0.error))")
            }
            
            XCTAssertTrue(value.map { $0.id }.sorted() == ids)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
