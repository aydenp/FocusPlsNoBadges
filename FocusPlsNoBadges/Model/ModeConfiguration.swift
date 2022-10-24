//
//  ModeConfigurations.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

struct ModeConfiguration: Codable {
    struct Mode: Codable {
        let name: String, modeIdentifier: String
    }

    struct Configuration: Codable {
        private let _hideApplicationBadges: Int

        var shouldHideApplicationBadges: Bool {
            return _hideApplicationBadges == 2
        }

        enum CodingKeys: String, CodingKey {
            case _hideApplicationBadges = "hideApplicationBadges"
        }
    }

    let mode: Mode, configuration: Configuration
}
