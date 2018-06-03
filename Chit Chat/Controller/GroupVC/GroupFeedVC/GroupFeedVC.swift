//
//  GroupFeedVC.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 03/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var membersLbl: UILabel!
    
    @IBOutlet weak var sendMessageView: UIView!
    
    @IBOutlet weak var messageTextField: InsetTextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMessageView.bindToKeyboard()
    }

    
    @IBAction func sendBtnDidTap(_ sender: Any) {
        
    }
    
    @IBAction func backBtnDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
