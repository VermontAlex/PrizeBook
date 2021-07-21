//
//  TableViewCell.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

final class PrizeTableViewCell: UITableViewCell {
    
    private struct Default {
        static let borderWidth: CGFloat = 20
        static let cornerRadius: CGFloat = 40
        static let borderColor = UIColor(red: 0.953, green: 0.984, blue: 1, alpha: 1).cgColor
    }
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var nameOfPrizeLabel: UILabel!
    @IBOutlet weak var priceOfPrizeLabel: UILabel!
    @IBOutlet weak var photoOfPrize: UIImageView!
    
    static let identifier = "PrizeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        photoOfPrize.makeRounded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameOfPrizeLabel.text = nil
        priceOfPrizeLabel.text = nil
        photoOfPrize.image = nil
        selectedView.backgroundColor = .white
    }
    
    func fillCell(prize: PrizeModel) {
        nameOfPrizeLabel.text = prize.name
        priceOfPrizeLabel.text = String(prize.price)
        selectedView.backgroundColor = prize.selected ? .systemGreen : .white
    }
    
    private func configureCell(){
        layer.borderWidth = Default.borderWidth
        layer.borderColor = Default.borderColor
        layer.cornerRadius = Default.cornerRadius
        clipsToBounds = true
        photoOfPrize.contentMode = .scaleAspectFill
    }
}

private extension UIImageView {
    func makeRounded() {
        let radius = self.frame.width / 2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
