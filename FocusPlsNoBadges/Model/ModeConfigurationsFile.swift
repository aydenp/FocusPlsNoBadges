//
//  ModeConfigurationsFile.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

struct ModeConfigurationsFile: Codable {
    struct DataObject: Codable {
        let modeConfigurations: [String: ModeConfiguration]
    }

    private let data: [DataObject]

    var modeConfigurations: [ModeConfiguration] {
        return data.flatMap { $0.modeConfigurations.values }
    }
}
