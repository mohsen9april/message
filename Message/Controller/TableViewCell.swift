//
//  TableViewCell.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var myAvatar: UIImageView!
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var messageBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.black.cgColor
        myAvatar.layer.cornerRadius = avatar.frame.width / 2
        myAvatar.layer.borderWidth = 1
        myAvatar.layer.borderColor = UIColor.black.cgColor
        messageBackground.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
