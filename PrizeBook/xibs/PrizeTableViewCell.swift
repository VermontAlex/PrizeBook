//
//  TableViewCell.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

class PrizeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var nameOfPrizeLabel: UILabel!
    @IBOutlet weak var priceOfPrizeLabel: UILabel!
    @IBOutlet weak var photoOfPrize: UIImageView!
    
    static let identifier = "PrizeTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameOfPrizeLabel.text = nil
        priceOfPrizeLabel.text = nil
        photoOfPrize.image = nil
    }
    
    func fillCell(prize: PrizeModel) {
        nameOfPrizeLabel.text = prize.name
        priceOfPrizeLabel.text = String(prize.price)
        photoOfPrize.makeRounded()
        if prize.selected == true {
            selectedView.backgroundColor = .green
        } else {
            selectedView.backgroundColor = .lightGray
        }
    }
}

extension UIImageView {
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
