//
//  TrackResultViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class TrackResultViewController: UIViewController {

    @IBOutlet var logoView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    
    // Info's labels
    @IBOutlet weak var lblBlawb: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblFinalDestination: UILabel!
    @IBOutlet weak var lblExporter: UILabel!
    @IBOutlet weak var lblInitialDate: UILabel!
    
    var trackResult: [Tracking]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.registerGoogleAnalytics(classForCoder: self.classForCoder)
    }
    
    func initSubviews() {
        self.navigationItem.titleView = logoView
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: nil, action: nil)
        
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 1))
        
        if trackResult != nil {
            
            lblBlawb.text = trackResult?.first?.blawb
            lblType.text = trackResult?.first?.type
            lblCompany.text = trackResult?.first?.company
            lblOrigin.text = trackResult?.first?.origin
            lblFinalDestination.text = trackResult?.first?.finaldestination
            lblExporter.text = trackResult?.first?.exporter
            lblInitialDate.text = trackResult?.first?.initialDate
            
        }
    }
    
    @objc func imageTapped(_ sender: AnyObject) {
        
        if trackResult?.count != 0 {
            let url = URL(string: trackResult!.first!.status![sender.view.tag].document!)
            let browserViewController = storyboard?.instantiateViewController(withIdentifier: "browserViewController") as! BrowserViewController
            
            browserViewController.url = url
            
            self.present(browserViewController, animated: true, completion: nil)
        }
        
    }

}

// MARK: - TrackViewController - UITableViewDataSource, UITableViewDelegate
extension TrackResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = trackResult?.first?.status?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.lblDate.text = trackResult?.first?.status?[indexPath.row].data
        cell.lblStatus.text = trackResult?.first?.status?[indexPath.row].status

        let contentSize = cell.lblStatus.sizeThatFits(cell.lblStatus.bounds.size)
        var frame = cell.lblStatus.frame
        frame.size.height = contentSize.height
        cell.lblStatus.frame = frame
        
        if trackResult?.first?.status?[indexPath.row].document != nil {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            cell.imgUpload.image = #imageLiteral(resourceName: "ic_insert_link_white")
            cell.imgUpload.tag = indexPath.row
            cell.imgUpload.isUserInteractionEnabled = true
            cell.imgUpload.addGestureRecognizer(tapGestureRecognizer)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        
        if trackResult != nil {
            cell.lblStatus.text = trackResult?.first?.status?[indexPath.row].status
            
            let contentSize = cell.lblStatus.sizeThatFits(cell.lblStatus.bounds.size)
            var frame = cell.lblStatus.frame
            frame.size.height = contentSize.height
            
            return frame.height + 14
        }
        
        return 44

    }
    
}
