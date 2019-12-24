//
//  CategoryViewController.swift
//  Todoey
//
//  Created by AJ Genung on 12/16/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadCategories()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = self.categoryArray[indexPath.row].name
        
        
        return cell
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (acton) in
            
            if (textField.text != "") {
                
                let newCategory = Category()
                newCategory.name = textField.text!
                self.categoryArray.append(newCategory)
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
            destination.selectedCategory = self.categoryArray[indexPath.row]
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
    
//    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest()) -> Void {
//        do {
//            categoryArray = try context.fetch(request)
//            tableView.reloadData()
//        } catch {
//            print("Error loading Categories: \(error)")
//        }
//    }
    
}
