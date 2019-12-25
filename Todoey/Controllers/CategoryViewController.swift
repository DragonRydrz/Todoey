//
//  CategoryViewController.swift
//  Todoey
//
//  Created by AJ Genung on 12/16/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    var categories: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = self.categories?[indexPath.row].name ?? "No Categories Added"
        cell.backgroundColor = UIColor(hexString: self.categories?[indexPath.row].color ?? "1D9BF6")
        
        
        
        
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
                newCategory.color = UIColor.randomFlat().hexValue()
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
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
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
//        tableView.reloadData()
    }
    
}
//MARK: - Swipe Cell Delegate Methods
