//
//  CodableBundle+Extensions.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//

import Foundation
extension Bundle {
    func decode<T: Codable>(_ file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw NSError(domain: "BundleDecodeError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to locate \(file) in bundle."])
        }

        guard let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "BundleDecodeError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to load \(file) from bundle."])
        }

        let decoder = JSONDecoder()

        do {
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            throw NSError(domain: "BundleDecodeError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to decode \(file): \(error.localizedDescription)"])
        }
    }
}
