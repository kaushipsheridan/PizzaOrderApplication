//
//  OrderCell.swift
//  Assignment1_Priyanshu
//
//  Created by Priyanshu Kaushik on 2025-03-23.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet var primaryLabel: UILabel!
    @IBOutlet var secondaryLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
