//
//  CreateGroupVC.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 01/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneDidTap(_ sender: Any) {
        
    }
    
    @IBAction func closeDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
