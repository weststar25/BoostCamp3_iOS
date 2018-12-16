//
//  CircleImageView.swift
//  BC3iOS
//
//  Created by 김지우 on 2018. 12. 16..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class CircleImageView : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
            self.frame = CGRect(x: 64, y: 64, width: 64, height: 64)
            self.clipsToBounds = true
            self.layer.borderWidth = 0.0
            self.layer.cornerRadius = self.frame.size.width/2.0
    }
}
