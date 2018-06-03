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
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMessageView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmails(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
    }
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    @IBAction func sendBtnDidTap(_ sender: Any) {
        
    }
    
    @IBAction func backBtnDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
