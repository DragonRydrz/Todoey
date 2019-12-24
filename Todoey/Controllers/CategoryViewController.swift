//
//  CategoryViewController.swift
//  Todoey
//
//  Created by AJ Genung on 12/16/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {

    var categories: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        loadCategories()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = self.categories?[indexPath.row].name ?? "No Categories Added"
        
        
        return cell
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (acton) in
            
            if (textField.text != "") {
                
                let newCategory = Category()
                newCategory.name = textField.text!
//                self.categories.append(newCategory)
                self.save(category: newCategory)
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
    
    //MARK - TableView Data Methods
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoeyTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = self.categories?[indexPath.row]
        }
    }
    
    //MARK - Data Manipulation Methods
    
    func save(category: Category) -> Void {
        do {
            try realm.write {
                realm.add(category)
            }
            tableView.reloadData()
        } catch {
            print("Error Saving Context: \(error)")
        }
    }
    
    func loadCategories () -> Void {
        categories = realm.objects(Category.self)
    }
    
}
//MARK: - Swipe Cell Delegate Methods
extension CategoryViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if let selectedCategory = self.categories?[indexPath.row] {
                for i in selectedCategory.items {
                    do {
                        try self.realm.write {
                            self.realm.delete(i)
                        }
                    } catch {
                        print("Error deleting item on \(selectedCategory.name): \(error)")
                    }
                }
                do {
                    try self.realm.write {
                        self.realm.delete(selectedCategory)
                    }
                } catch {
                    print("Error deleting Category: \(error)")
                }
            }
//            tableView.reloadData()
        }
        
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
