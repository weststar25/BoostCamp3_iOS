//
//  MovieCollectionViewCell.swift
//  BoostCamp3iOS
//
//  Created by 김지우 on 2018. 12. 13..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    private let highlightedColor = UIColor(hexString: "C6C6C6")
    var shouldTintBackgroundWhenSelected = true
    var specialHighlightedArea: UIView?
    
    override var isHighlighted: Bool {
        willSet {
            onSelected(newValue)
        }
    }
    
    override var isSelected: Bool {
        willSet {
            onSelected(newValue)
        }
    }
    func onSelected(_ newValue: Bool) {
        guard selectedBackgroundView == nil else { return }
        if shouldTintBackgroundWhenSelected {
            contentView.backgroundColor = newValue ? highlightedColor : UIColor.clear
        }
        if let sa = specialHighlightedArea {
            sa.backgroundColor = newValue ? UIColor.black.withAlphaComponent(0.4) : UIColor.clear
        }
    }
    
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingIcon: UIImageView!
    @IBOutlet weak var reservationRankLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var reservationRatingLabel: UILabel!
    @IBOutlet weak var releaseDayLabel: UILabel!
    
    let allIcon: UIImage = #imageLiteral(resourceName: "All_Icon")
    let twelveIcon: UIImage = #imageLiteral(resourceName: "12_Icon")
    let fifteenIcon: UIImage = #imageLiteral(resourceName: "15_Icon")
    let nineteenIcon: UIImage = #imageLiteral(resourceName: "19_Icon")
}
