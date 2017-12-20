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
        // Dispose of any resources that can be recreated.
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
            print(airIndex.stIndexLevel)
            cell?.airIndexLabel.text = airIndex.stIndexLevel?.indexLevelName
            cell?.addGradientForIndex(idIndex: (airIndex.stIndexLevel?.id)!)
            
            
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

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
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

