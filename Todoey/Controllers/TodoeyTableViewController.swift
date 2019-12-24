//
//  ViewController.swift
//  Todoey
//
//  Created by AJ Genung on 12/5/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import UIKit
import CoreData

class TodoeyTableViewController: UITableViewController {

    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet {
            
//            loadItems()
        }
    }
    
//    let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
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
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].complete = !itemArray[indexPath.row].complete
        self.saveItems()
        
        
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
                
//                let newItem = Item(context: self.context)
//                newItem.title = textField.text!
//                newItem.parentCategory = self.selectedCategory
//                self.itemArray.append(newItem)
//                //self.defaults.set(self.itemArray, forKey: "TodoListArray")
//                self.saveItems()
//                self.tableView.reloadData()
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
            tableView.reloadData()
        } catch {
            print("Error saving Context: \(error)")
        }
    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) -> Void {
//
//        //let request: NSFetchRequest<Item> = Item.fetchRequest()
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//
//        if let additionalPredicate = predicate {
//            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//            request.predicate = compoundPredicate
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//
//        do {
//            itemArray = try context.fetch(request)
//            tableView.reloadData()
//        } catch {
//            print("Error fetching data: \(error)")
//        }
//
//
//    }
}
//MARK: - Search Bar Methods
extension TodoeyTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
////        do {
////            itemArray = try context.fetch(request)
////            tableView.reloadData()
////        } catch {
////            print("Error fetching data: \(error)")
////        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count == 0) {
//            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}
