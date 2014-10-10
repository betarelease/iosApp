//
//  ViewController.swift
//  helloworld
//
//  Created by Sudhindra Rao on 10/6/14.
//  Copyright (c) 2014 Sudhindra Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,APIControllerProtocol {

    @IBOutlet weak var appsTableView: UITableView!
    var tableData = []
    var api = APIController()
    let kCellIdentifier = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.api.delegate = self
        api.searchItunesFor("JQ Software")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = results
            self.appsTableView!.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["content"] as? String
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
//        let urlString: NSString = rowData["artworkUrl60"] as NSString
//        let imgURL: NSURL = NSURL(string: urlString)
        
        // Download an NSData representation of the image at the URL
//        let imgData: NSData = NSData(contentsOfURL: imgURL)
//        cell.imageView?.image = UIImage(data: imgData)
        
        // Get the formatted price string for display in the subtitle
//        let formattedPrice: NSString = rowData["position"] as NSString
        
        cell.detailTextLabel?.text = rowData["position"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        var name: String = rowData["content"] as String
        
        var alert: UIAlertView = UIAlertView()
        alert.title = name
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
}