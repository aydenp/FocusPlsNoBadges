//
//  AssertionsFile.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

struct AssertionsFile: Codable {
    struct DataObject: Codable {
        let storeAssertionRecords: [AssertionRecord]?
    }

    private let data: [DataObject]

    var activeAssertions: [AssertionRecord] {
        return data.flatMap { $0.storeAssertionRecords ?? [] }
    }

    var activeModeIdentifier: String? {
        return activeAssertions.first?.details.modeIdentifier
    }
}
