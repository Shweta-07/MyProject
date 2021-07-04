//
//  MyDataTableViewCell.swift
//  MyProject
//
//  Created by user199453 on 7/3/21.
//

import UIKit

class MyDataTableViewCell: UITableViewCell {
    
    @IBOutlet var avatarDotImage: UIImageView!
    
    @IBOutlet var fullNameLabe: UILabel!
    
    @IBOutlet var loginLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
