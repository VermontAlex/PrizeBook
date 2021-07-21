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
            selectedView.backgroundColor = .systemGreen
        } else {
            selectedView.backgroundColor = .white
        }
        configureCell()
    }
    private func configureCell(){
        layer.borderWidth = 20
        layer.borderColor = UIColor(red: 0.953, green: 0.984, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 40
        clipsToBounds = true
        photoOfPrize.contentMode = .scaleAspectFill
    }
}

extension UIImageView {
    func makeRounded() {
        let radius = self.frame.width / 2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
