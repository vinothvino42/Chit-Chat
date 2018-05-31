//
//  Message.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 31/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import Foundation

class Message {
    
    private var _content: String
    private var _senderId: String
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
}
