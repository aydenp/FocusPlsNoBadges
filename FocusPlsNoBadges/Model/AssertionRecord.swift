//
//  AssertionRecord.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

struct AssertionRecord: Codable {
    struct Details: Codable {
        let modeIdentifier: String

        enum CodingKeys: String, CodingKey {
            case modeIdentifier = "assertionDetailsModeIdentifier"
        }
    }

    let details: Details

    enum CodingKeys: String, CodingKey {
        case details = "assertionDetails"
    }
}
