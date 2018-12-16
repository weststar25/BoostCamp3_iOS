//
//  TableListVC.swift
//  BoostCamp3iOS
//
//  Created by 김지우 on 2018. 12. 11..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class TableListVC : UIViewController {
    var orderType: Int = 0
    var errorMsg: String = ""
    var movieList: [MovieListVO] = []
    let boxOfficeService: BoxOfficeService = BoxOfficeService()
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    @IBAction func sortBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: "정렬 방식 선택", message: nil, preferredStyle: .actionSheet)
        let ratingAction = UIAlertAction(title: "예매율", style: .default, handler: {
            (action:UIAlertAction) in
            self.orderType = 0
            self.navigationItem.title = "개봉일순"
            self.getMovieListHandler(self.orderType)
        })
        let curationAction = UIAlertAction(title: "큐레이션", style: .default, handler: {
            (action:UIAlertAction) in
            self.orderType = 1
            self.navigationItem.title = "큐레이션"
            self.getMovieListHandler(self.orderType)
        })
        let releseDateAction = UIAlertAction(title: "개봉일", style: .default, handler: {
            (action:UIAlertAction) in
            self.orderType = 2
            self.navigationItem.title = "개봉일순"
            self.getMovieListHandler(self.orderType)
        })
        
        alert.addAction(ratingAction)
        alert.addAction(curationAction)
        alert.addAction(releseDateAction)
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
        self.navigationItem.title = "예매율순"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getMovieListHandler(self.orderType)
    }
    
    func getMovieListHandler(_ orderType: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        boxOfficeService.getMovieList(orderType: orderType) { (movieList, errorMsg) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if !errorMsg.isEmpty {
                self.simpleAlert(title: "Error", message: errorMsg)
                return
            }
            self.movieList = movieList
            self.movieListTableView.reloadData()
        }
    }
    
}

extension TableListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else{
                return
        }
        dvc.movieId = self.movieList[indexPath.row].id
        dvc.movieTitle = self.movieList[indexPath.row].title
        navigationController?.pushViewController(dvc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        var movieRatingIcon: UIImage
        switch self.movieList[indexPath.row].grade {
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
        cell.posterImgView.downloaded(from: self.movieList[indexPath.row].thumb)
        cell.movieTitleLabel.text = self.movieList[indexPath.row].title
        cell.gradeLabel.text = "\(self.movieList[indexPath.row].user_rating)"
        cell.reservationRankLabel.text = "\(self.movieList[indexPath.row].reservation_grade)"
        cell.reservationRatingLabel.text = "\(self.movieList[indexPath.row].reservation_rate)"
        cell.movieRatingIcon.image = movieRatingIcon
        cell.releaseDayLabel.text = self.movieList[indexPath.row].date
        
        return cell
    }
}
