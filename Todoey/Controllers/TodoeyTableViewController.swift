//
//  ViewController.swift
//  Todoey
//
//  Created by AJ Genung on 12/5/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    }
    
    //MARK - TabelView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.complete ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK -- TableView Delegate MEthod
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Item selected was \(itemArray[indexPath.row]), at index \(indexPath.row)")
        
        itemArray[indexPath.row].complete = !itemArray[indexPath.row].complete
        self.saveItems()
        tableView.reloadData()
        
//        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none) {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        } else if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark) {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (acton) in
            if (textField.text != "") {
                
                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                //self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.saveItems()
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems () -> Void {
        
        do {
            try context.save()
            
        } catch {
            print("Error saving Context: \(error)")
        }
    }
    
//    func loadItems() -> Void {
//
//        if let data = try? Data(contentsOf: dataFilePath!) {
//
//
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//
//                print("Error decoding data: \(error)")
//            }
//        }
//    }
    

}

