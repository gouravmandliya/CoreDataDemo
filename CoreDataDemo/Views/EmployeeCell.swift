//
//  EmployeeCell.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
