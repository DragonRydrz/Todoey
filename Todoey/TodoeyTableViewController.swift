//
//  ViewController.swift
//  Todoey
//
//  Created by AJ Genung on 12/5/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {

    let itemArray = ["Find Mike","Buy Eggs","Destroy Demigorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - TabelView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK -- TableView Delegate MEthod
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Item selected was \(itemArray[indexPath.row]), at index \(indexPath.row)")
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

