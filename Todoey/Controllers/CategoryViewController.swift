//
//  CategoryViewController.swift
//  Todoey
//
//  Created by AJ Genung on 12/16/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let categoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    //MARK - TableView Data Methods
    
    //MARK - TableView Delegate Methods
    
    //MARK - Data Manipulation Methods
    
    
}
