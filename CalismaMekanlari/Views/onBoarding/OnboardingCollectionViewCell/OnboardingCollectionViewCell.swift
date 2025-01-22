//
//  OnboardingCollectionViewCell.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 22.01.2025.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var mainLbl1: UILabel!
    @IBOutlet weak var bodyLbl1: UILabel!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var mainLbl2: UILabel!
    @IBOutlet weak var bodyLbl2: UILabel!
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var mainLbl3: UILabel!
    @IBOutlet weak var bodyLbl3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
        
        
        
    }
    
    
    func setup(_ slide: OnboardingSlide) {
        headerLbl.text = slide.title
        
        mainLbl1.text = slide.mainTitles[0].title
        bodyLbl1.text = slide.mainTitles[0].description
        image1.image = UIImage(named: slide.mainTitles[0].image)
        
        mainLbl2.text = slide.mainTitles[1].title
        bodyLbl2.text = slide.mainTitles[1].description
        image2.image = UIImage(named: slide.mainTitles[1].image)
        
        mainLbl3.text = slide.mainTitles[2].title
        bodyLbl3.text = slide.mainTitles[2].description
        image3.image = UIImage(named: slide.mainTitles[2].image)
      }

}
