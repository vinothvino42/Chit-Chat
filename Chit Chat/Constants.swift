//
//  Constants.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 28/11/17.
//  Copyright © 2017 CoderEarth. All rights reserved.
//

import FirebaseDatabase

struct Constants {
    
    struct refs {
        
        static let databaseRoot = Database.database().reference()
        static let chatsReference = databaseRoot.child("chats")
    }
}
