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
    
    var todos = [Todo]()
    
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
            self.todos = Todo.todosWithJSON(results)
            self.appsTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        let todo = self.todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var detailsViewController: DetailsViewController = segue.destinationViewController as DetailsViewController
        var todoIndex = appsTableView!.indexPathForSelectedRow()!.row
        var selectedTodo = self.todos[todoIndex]
        detailsViewController.todo = selectedTodo
    }
}