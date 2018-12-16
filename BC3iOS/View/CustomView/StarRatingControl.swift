//
//  StarRatingControl.swift
//  BC3iOS
//
//  Created by 김지우 on 2018. 12. 16..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

@IBDesignable class StarRatingControl: UIStackView {
    //MARK: Properties
    private var ratingStars = [UIImageView]()
    
    let emptyStar = UIImage(named:"EmptyStar")
    let halfStar = UIImage(named:"HalfStar")
    let filledStar = UIImage(named:"FilledStar")
    
    @IBInspectable var starSize: CGSize = CGSize(width: 17.0, height: 17.0) {
        didSet {
            setup(0)
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setup(0)
        }
    }
    
    //Mark: private Methods
    private func setup(_ orderType: Int) {
        for star in ratingStars {
            removeArrangedSubview(star)
            star.removeFromSuperview()
        }
        ratingStars.removeAll()
        
        for cnt in 0..<starCount {
            let star = UIImageView()
            
            switch orderType {
            case 1:
                if cnt < 1 { star.image = halfStar }
                else { star.image = emptyStar }
                break
            case 2:
                if cnt < 1 { star.image = filledStar }
                else { star.image = emptyStar }
                break
            case 3:
                if cnt < 1 { star.image = filledStar }
                else if cnt == 1 { star.image = halfStar }
                else { star.image = emptyStar }
                break
            case 4:
                if cnt < 2 { star.image = filledStar }
                else { star.image = emptyStar }
                break
            case 5:
                if cnt < 2 { star.image = filledStar }
                else if cnt == 2 { star.image = halfStar }
                else { star.image = emptyStar }
                break
            case 6:
                if cnt < 3 { star.image = filledStar }
                else { star.image = emptyStar }
                break
            case 7:
                if cnt < 3 { star.image = filledStar }
                else if cnt == 3 { star.image = halfStar }
                else { star.image = emptyStar }
                break
            case 8:
                if cnt < 4 { star.image = filledStar }
                else { star.image = emptyStar }
                break
            case 9:
                if cnt < 4 { star.image = filledStar }
                else if cnt == 4 { star.image = halfStar }
                else { star.image = emptyStar }
                break
            case 10:
                if cnt < 5 { star.image = filledStar }
                else { star.image = emptyStar }
                break
            default:
                star.image = emptyStar
                break
            }
            
            star.translatesAutoresizingMaskIntoConstraints = false
            star.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            star.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            addArrangedSubview(star)
            
            ratingStars.append(star)
        }
    }
    
    func changeImage(_ rating: Double) {
        let calcRatingData = rating/2.0
        
        if (0.0 < calcRatingData) && (calcRatingData <= 0.5) {
            self.setup(1)
        } else if (0.5 < calcRatingData) && (calcRatingData <= 1.0) {
            self.setup(2)
        } else if (1.0 < calcRatingData) && (calcRatingData <= 1.5) {
            self.setup(3)
        } else if (1.5 < calcRatingData) && (calcRatingData < 2.0) {
            self.setup(4)
        } else if (2.0 < calcRatingData) && (calcRatingData <= 2.5) {
            self.setup(5)
        } else if (2.5 < calcRatingData) && (calcRatingData <= 2.5) {
            self.setup(6)
        } else if (3.0 < calcRatingData) && (calcRatingData <= 3.5) {
            self.setup(7)
        } else if (3.5 < calcRatingData) && (calcRatingData <= 4.0) {
            self.setup(8)
        } else if (4.0 < calcRatingData) && (calcRatingData <= 4.5) {
            self.setup(9)
        } else {
            self.setup(10)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(0)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup(0)
    }
}
