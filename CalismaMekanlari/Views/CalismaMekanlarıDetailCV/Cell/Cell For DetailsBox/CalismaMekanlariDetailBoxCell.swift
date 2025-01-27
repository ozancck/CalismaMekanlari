//
//  CalismaMekanlariDetailBoxCell.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 27.01.2025.
//

import UIKit

class CalismaMekanlariDetailBoxCell: UICollectionViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.darkCellBackground.cgColor
        borderView.backgroundColor = .clear
        borderView.layer.masksToBounds = true
        
    }

}
