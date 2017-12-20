//
//  CitiesViewController.swift
//  SmogApp
//
//  Created by Krystian Bylica on 19.12.2017.
//  Copyright © 2017 Krystian Bylica. All rights reserved.
//

import UIKit


class MainViewController: UIViewController,StationViewModelDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private let viewModel = StationViewModel()
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: StationCollectionViewLayout!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        self.collectionView.isHidden = true
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.numberOfStationForActualCity())
        return viewModel.numberOfStationForActualCity()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stationCell", for: indexPath) as? StationCollectionViewCell
        cell?.stationNameLabel.text = viewModel.stationNameToDisplay(for: indexPath)
        
        viewModel.getAirIndex(for: indexPath) { (airIndex) in
            cell?.airIndexLabel.text = airIndex.stIndexLevel?.indexLevelName
            if let idIndexLevel = airIndex.stIndexLevel?.id{
                 cell?.addGradientForIndex(idIndex: idIndexLevel)
            }
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-20, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.indexPathsForVisibleItems.first {
            pageControl.currentPage = indexPath.row
        }
    }
    
    func setNewData(nearestStation: Station) {
        self.cityNameLabel.text = nearestStation.city?.name
        self.collectionView.isHidden = false
        self.indicatorView.isHidden = true
        self.collectionView.reloadData()
        self.pageControl.numberOfPages = viewModel.numberOfStationForActualCity()
        
    }

}

class StationCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let pageWidth = itemSize.width + minimumLineSpacing
        
        let pagesCount = proposedContentOffset.x / pageWidth
        let pages = round(pagesCount)
        let rest = pagesCount - pages
        
        let closestPage = Int(pages + (rest <= 0.5 ? 0 : 1))
        return CGPoint(x: pageWidth * CGFloat(closestPage), y: proposedContentOffset.y)
    }
}

