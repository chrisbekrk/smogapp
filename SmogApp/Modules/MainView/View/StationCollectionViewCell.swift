//
//  StationCollectionViewCell.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import UIKit

class StationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var airIndexLabel: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!

    @IBOutlet weak var backgroundMaskView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundMaskView.layer.masksToBounds = false
        backgroundMaskView.layer.shadowColor = UIColor.black.cgColor
        backgroundMaskView.layer.shadowOpacity = 0.2
        backgroundMaskView.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundMaskView.layer.shadowRadius = 4
        backgroundMaskView.layer.cornerRadius = 5
       // layer.cornerRadius = 5
        // Initialization code
    }
    
    override var isHighlighted: Bool {
        didSet {
            
            let options: UIViewAnimationOptions = self.isHighlighted ? [.curveEaseOut] : [.curveEaseIn]
            
            UIView.animate(withDuration: 0.15,
                           delay: 0.0,
                           options: options, animations: {
                            
                            if self.isHighlighted {
                                self.contentView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                            } else {
                                self.contentView.transform = CGAffineTransform.identity
                            }
            })
        }
    }
    
    
}
