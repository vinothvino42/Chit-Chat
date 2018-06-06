//
//  String+CurrentTimeInMilliSeconds.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 06/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import Foundation

extension String {
    func currentTimeInMilliSeconds() -> Int64 {
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble * 1000)
    }
}
