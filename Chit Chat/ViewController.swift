//
//  ViewController.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 28/11/17.
//  Copyright © 2017 CoderEarth. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseDatabase

class ChatVC: JSQMessagesViewController {

    var messages = [JSQMessage]()
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        
        if  let id = defaults.string(forKey: "id"),
            let name = defaults.string(forKey: "myname") {
            senderId = id
            senderDisplayName = name
            
        } else {
            senderId = String(arc4random_uniform(999999))
            senderDisplayName = ""
            
            defaults.set(senderId, forKey: "id")
            defaults.synchronize()
            
            showDisplayNameDialog()
        }
        
        title = "Chat: \(senderDisplayName!)"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDisplayNameDialog))
        tapGesture.numberOfTapsRequired = 1
        
        navigationController?.navigationBar.addGestureRecognizer(tapGesture)
        
        
        
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        
        let query = Constants.refs.chatsReference.queryLimited(toLast: 10)
        _ = query.observe(DataEventType.childAdded, with: { [weak self] snapshot in
            
            if  let data = snapshot.value as? [String: String],
                let id = data["sender_id"],
                let name = data["name"],
                let text = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self?.messages.append(message)
                    
                    self?.finishReceivingMessage()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showDisplayNameDialog()
    {
        let userDefaults = UserDefaults.standard
        
        let alert = UIAlertController(title: "Display Name", message: "Enter your name please", preferredStyle: .alert)
        
        alert.addTextField { textField in
            
            if let name = userDefaults.string(forKey: "myname")
            {
                textField.text = name
            }
            else
            {
                textField.text = ""
            }
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] _ in
            
            if let textField = alert?.textFields?[0], !textField.text!.isEmpty {
                
                self?.senderDisplayName = textField.text
                
                self?.title = "You: \(self!.senderDisplayName!)"
                
                userDefaults.set(textField.text, forKey: "myname")
                userDefaults.synchronize()
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let ref = Constants.refs.chatsReference.childByAutoId()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        
        ref.setValue(message)
        finishSendingMessage()
    }
}

