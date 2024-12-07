//
//  BundleDecodeTests.swift
//  english-wordsTests
//
//  Created by Barış Dilekçi on 7.12.2024.
//

import XCTest
@testable import english_words


final class BundleDecodeTests: XCTestCase {
    
    func testDecodeValidJSON() {
        let bundle = Bundle(for: BundleDecodeTests.self)
        
        do {
            let decoded: WordList = try bundle.decode("word.json")
            
            XCTAssertEqual(decoded.words.first?.id, 1, "Decoded ID should match JSON data")
            XCTAssertEqual(decoded.words.first?.categoryId, 1, "Decoded categoryId should match JSON data")
            XCTAssertEqual(decoded.words.first?.ENG, "a", "Decoded ENG should match JSON data")
            XCTAssertEqual(decoded.words.first?.TR, "bir", "Decoded TR should match JSON data")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

    func testDecodeMissingFile() {
        let bundle = Bundle(for: BundleDecodeTests.self)
        
        XCTAssertThrowsError(try bundle.decode("missing.json") as WordList, "Should throw error for missing file") { error in
            XCTAssert(error.localizedDescription.contains("Failed to locate"), "Error should indicate missing file")
        }
    }
}
