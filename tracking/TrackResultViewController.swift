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
    
    var trackResult: [Tracking]?
    
    
    var dates = ["26/04/2017", "10/05/2017", "12/05/2017", "02/0/20176", "09/07/2017"]
    var status = ["In transit on the ocean", "In transit on the ocean and this is a test to change height of cell", "In transit on the ocean", "In transit on the ocean", "Posted in Victoria's Porto"]
    var docs = [#imageLiteral(resourceName: "ic_insert_link_white"), #imageLiteral(resourceName: "ic_insert_link_white"), #imageLiteral(resourceName: "ic_insert_link_white"), #imageLiteral(resourceName: "ic_insert_link_white"), #imageLiteral(resourceName: "ic_insert_link_white")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubviews()
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
    }
    
    @objc func imageTapped(_ sender: AnyObject) {
        
        print("\(sender.view.tag)")
        
        let url = URL(string: "https://www.apple.com/lae/")
        
        let browserViewController = storyboard?.instantiateViewController(withIdentifier: "browserViewController") as! BrowserViewController
        
        browserViewController.url = url
        
        self.present(browserViewController, animated: true, completion: nil)
        
    }
    
    // TODO - To put in extension
    func calculateHeight(textView:UITextView, data:String) -> CGRect {
        
        var newFrame:CGRect!
        
        textView.text = data
        
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        print("height \(newFrame.height)")
        return newFrame
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
        
        if trackResult?.first?.status?[indexPath.row].document != "false" {
            cell.imgUpload.image = #imageLiteral(resourceName: "ic_insert_link_white")
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        
        cell.imgUpload.tag = indexPath.row
        cell.imgUpload.isUserInteractionEnabled = true
        cell.imgUpload.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.lblStatus.text = status[indexPath.row]
        
        let contentSize = cell.lblStatus.sizeThatFits(cell.lblStatus.bounds.size)
        var frame = cell.lblStatus.frame
        frame.size.height = contentSize.height
        //cell.lblStatus.frame = frame
        
        return frame.height + 14
        
    }
    
}
