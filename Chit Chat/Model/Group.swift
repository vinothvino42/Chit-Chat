//
//  Group.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 03/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import Foundation

class Group {
    
    private var _groupTitle: String
    private var _groupDesc: String
    private var _memberCount: Int
    private var _key: String
    private var _members: [String]

    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDesc: String {
        return _groupDesc
    }
    
    var memberCount: Int {
        return _memberCount
    }
    
    var key: String {
        return _key
    }
    
    var members: [String] {
        return _members
    }
    
    init(title: String, description: String, memberCount: Int, key: String, members: [String]) {
        self._groupTitle = title
        self._groupDesc = description
        self._memberCount = memberCount
        self._key = key
        self._members = members
    }
}
