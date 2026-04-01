//
//  TableCell.swift
//  CryptoCrazy
//
//  Created by Zeki Mac on 1.04.2026.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var item : Crypto!{
        didSet{
            currencyLabel.text = item.currency
            priceLabel.text = item.price
        }
    }

}
