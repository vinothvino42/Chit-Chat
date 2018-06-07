//
//  KVNProgress+ShowProgress.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 07/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import KVNProgress

extension KVNProgress {
    class func showProgress() {
        let progress = KVNProgressConfiguration.default()
        progress?.isFullScreen = true
        KVNProgress.setConfiguration(progress)
        KVNProgress.show(withStatus: "Loading..")
    }
}
