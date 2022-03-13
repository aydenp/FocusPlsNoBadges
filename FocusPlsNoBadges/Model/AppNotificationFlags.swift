//
//  AppNotificationFlags.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

struct AppNotificationFlags {
    var integer: Int

    private static let badgeBitIndex = 1
    var areBadgesEnabled: Bool {
        get { self[Self.badgeBitIndex] }
        set { self[Self.badgeBitIndex] = newValue }
    }

    private subscript(bitIndex: Int) -> Bool {
        get {
            return integer >> bitIndex & 1 == 1
        }
        set {
            let newBitValue = newValue ? 1 : 0
            integer ^= ((-newBitValue ^ integer) & (1 << bitIndex))
        }
    }
}
