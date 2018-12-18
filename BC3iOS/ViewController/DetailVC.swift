//
//  DetailVC.swift
//  BoostCamp3iOS
//
//  Created by 김지우 on 2018. 12. 11..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    var movieId: String = ""
    var movieTitle: String = ""
    var movieInfo: MovieDetailVO?
    var movieComments: [MovieDetailCommentVO] = []
    
    let extraIndex: Int = 4
    let boxOfficeService: BoxOfficeService = BoxOfficeService()
    
    @IBOutlet weak var movieDetailInfoTableView: UITableView!
    
    @objc func posterImgTapGesture(_ sender: UIGestureRecognizer) {
        guard let pfspVC = storyboard?.instantiateViewController(withIdentifier: "PosterFullScreenPopupVC") as? PosterFullScreenPopupVC else{
            return
        }
        guard let movieInfo = self.movieInfo else { return }
        pfspVC.path = movieInfo.image
        self.present(pfspVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getMovieInfoHandler(self.movieId)
        self.movieDetailInfoTableView.delegate = self
        self.movieDetailInfoTableView.dataSource = self
    }
    
    func getMovieInfoHandler(_ movieID: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        boxOfficeService.getMovieInfo(movieID: movieID, onMovieTotalInfo: { (movieInfo, movieComments, errorMsg) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if !errorMsg.isEmpty {
                self.simpleAlert(title: "Error", message: errorMsg)
                return
            }
            self.movieInfo = movieInfo
            self.movieComments = movieComments
            self.movieDetailInfoTableView.reloadData()
        })
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.title = self.movieTitle
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font:UIFont(name: "SeoulHangangB", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieComments.count == 0 {
            return 0
        }
        return movieComments.count + self.extraIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as! MovieInfoCell
            var movieRatingIcon: UIImage
            guard let movieInfo = self.movieInfo else { return cell }
            switch movieInfo.grade {
            case 0:
                movieRatingIcon = cell.allIcon
            case 12:
                movieRatingIcon = cell.twelveIcon
            case 15:
                movieRatingIcon = cell.fifteenIcon
            case 19:
                movieRatingIcon = cell.nineteenIcon
            default:
                movieRatingIcon = #imageLiteral(resourceName: "LaunchScreenImg.png")
            }
            cell.posterImgView.downloaded(from: movieInfo.image)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.posterImgTapGesture(_:)))
            cell.posterImgView.isUserInteractionEnabled = true
            cell.posterImgView.addGestureRecognizer(gesture)
            cell.movieTitleLabel.text = movieInfo.title
            cell.movieRatingIcon.image = movieRatingIcon
            cell.releaseDateLabel.text = movieInfo.date + " 개봉"
            cell.runningTimeLabel.text = "\(movieInfo.duration)분"
            cell.ratingInfoLabel.text = "\(movieInfo.reservation_grade)위 \(movieInfo.reservation_rate)%"
            cell.gradeLabel.text = "\(movieInfo.user_rating)"
            cell.starRating.changeImage(movieInfo.user_rating)
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            cell.audienceLabel.text = numberFormatter.string(from: NSNumber(value: movieInfo.audience))!
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSummaryCell", for: indexPath) as! MovieSummaryCell
            guard let movieInfo = self.movieInfo else { return cell }
            cell.summaryLabel.text = movieInfo.synopsis
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDirectorActorCell", for: indexPath) as! MovieDirectorActorCell
            guard let movieInfo = self.movieInfo else { return cell }
            cell.directorLabel.text = movieInfo.director
            cell.actorsLabel.text = movieInfo.actor
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCommentCell", for: indexPath) as! MovieCommentCell
            cell.nicknameLabel.text = self.movieComments[indexPath.row - self.extraIndex].writer
            cell.starRating.changeImage(self.movieComments[indexPath.row - self.extraIndex].rating)
            let when = Date(timeIntervalSince1970: self.movieComments[indexPath.row - self.extraIndex].timestamp)
            let date = DateFormatter()
            date.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.writeTimeLabel.text = date.string(from: when)
            cell.commentLabel.text = self.movieComments[indexPath.row - self.extraIndex].contents
            return cell
        }
    }
}
