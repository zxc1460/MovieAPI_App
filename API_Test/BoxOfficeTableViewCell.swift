//
//  BoxOfficeTableViewCell.swift
//  API_Test
//
//  Created by Seok on 2020/10/27.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var audiCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
