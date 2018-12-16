//
//  PosterFullScreenPopupVC.swift
//  BC3iOS
//
//  Created by 김지우 on 2018. 12. 17..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class PosterFullScreenPopupVC: UIViewController {
    var path: String = ""
    @IBOutlet weak var posterFullImgView: UIImageView!
    
    @IBAction func popUpTapGesture(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        posterFullImgView.downloaded(from: path)
    }
}
