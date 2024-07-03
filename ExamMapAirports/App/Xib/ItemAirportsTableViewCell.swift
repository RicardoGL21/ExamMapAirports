//
//  ItemAirportsTableViewCell.swift
//  ExamMapAirports
//
//  Created by Ricardo Garcia on 02/07/24.
//

import UIKit

class ItemAirportsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblAirportName: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var viewLikeCard: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewLikeCard.layer.shadowColor = UIColor.black.cgColor
        viewLikeCard.layer.shadowOpacity = 0.3
        viewLikeCard.layer.shadowOffset = .zero
        viewLikeCard.layer.shadowRadius = 1
        viewLikeCard.layer.shouldRasterize = true
        viewLikeCard.layer.rasterizationScale = true ? UIScreen.main.scale : 1
        viewLikeCard.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
