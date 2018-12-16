//
//  MovieCommentCell.swift
//  BC3iOS
//
//  Created by 김지우 on 2018. 12. 16..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class MovieCommentCell: UITableViewCell {
    @IBOutlet weak var profileImgView: CircleImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var starRating: StarRatingControl!
    @IBOutlet weak var writeTimeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
}
