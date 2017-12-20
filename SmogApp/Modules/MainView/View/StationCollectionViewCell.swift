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
        backgroundMaskView.layer.cornerRadius = 8

    }
    
    func addGradientForIndex(idIndex: Int){
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = backgroundMaskView.bounds
        gradientLayer.masksToBounds = false
        
        gradientLayer.shadowOpacity = 0.2
        gradientLayer.shadowOffset = CGSize(width: 2, height: 2)
        gradientLayer.shadowRadius = 4
        gradientLayer.cornerRadius = 8
        
        var color1 = CustomColor.unknowAirIndexColor1
        var color2 = CustomColor.unknowAirIndexColor2
        
        switch idIndex {
        case 0:
            color1 = CustomColor.exelentAirIndexColor1
            color2 = CustomColor.exelentAirIndexColor2
        case 1:
            color1 = CustomColor.goodAirIndexColor1
            color2 = CustomColor.goodAirIndexColor2
        case 2:
            color1 = CustomColor.moderateAirIndexColor1
            color2 = CustomColor.moderateAirIndexColor2
        case 3:
            color1 = CustomColor.lowAirIndexColor1
            color2 = CustomColor.lowAirIndexColor2
        case 4:
            color1 = CustomColor.badAirIndexColor1
            color2 = CustomColor.badAirIndexColor2
        case 5:
            color1 = CustomColor.verybadAirIndexColor1
            color2 = CustomColor.verybadAirIndexColor2
        default:
            color1 = CustomColor.unknowAirIndexColor1
            color2 = CustomColor.unknowAirIndexColor2
        }
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.shadowColor = color1.cgColor
        
        for (index,layer) in backgroundMaskView.layer.sublayers!.enumerated(){
            if layer is CAGradientLayer{
                backgroundMaskView.layer.sublayers?.remove(at: index)
            }
        }
        
        backgroundMaskView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func changeFontColors(toWhite: Bool){
        
        
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
