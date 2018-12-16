//
//  MovieInfoCell.swift
//  BC3iOS
//
//  Created by 김지우 on 2018. 12. 16..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class MovieInfoCell: UITableViewCell {
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingIcon: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var ratingInfoLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var starRating: StarRatingControl!
    
    let allIcon: UIImage = #imageLiteral(resourceName: "All_Icon")
    let twelveIcon: UIImage = #imageLiteral(resourceName: "12_Icon")
    let fifteenIcon: UIImage = #imageLiteral(resourceName: "15_Icon")
    let nineteenIcon: UIImage = #imageLiteral(resourceName: "19_Icon")
}
