//
//  AuthorsMemoryStore.swift
//  SwiftyPress
//
//  Created by Basem Emara on 2018-06-04.
//

import ZamzamKit

public struct AuthorsFileStore: AuthorsStore {
    private let seedStore: SeedStore
    
    init(seedStore: SeedStore) {
        self.seedStore = seedStore
    }
}

public extension AuthorsFileStore {
    
    func fetch(id: Int, completion: @escaping (Result<AuthorType, DataError>) -> Void) {
        seedStore.fetch {
            guard let data = $0.value, $0.isSuccess else {
                return completion(.failure($0.error ?? .unknownReason(nil)))
            }
            
            // Find match
            guard let value = data.authors.first(where: { $0.id == id }) else {
                return completion(.failure(.nonExistent))
            }
            
            completion(.success(value))
        }
    }
}
