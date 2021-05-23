//
//  ViewController.swift
//  A2_FA_iOS_ranjana_C0793794
//
//  Created by Ranjana on 23/05/21.
//

import UIKit
import CoreData

class ListingVC:  UITableViewController {
    
    var products: [Product]?
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = products![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
        
        cell?.textLabel?.text = product.productName
        cell?.detailTextLabel?.text = product.productDescription

        return cell!
    }
    
    func loadCoreData() {
     
       // let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            products = try managedContext.fetch(request)
            
//            if results is [NSManagedObject] {
//                for result in (results as! [NSManagedObject]) {
//                    let title = result.value(forKey: "title") as! String
//                    let author = result.value(forKey: "author") as! String
//                    let pages = result.value(forKey: "pages") as! Int
//                    let year = result.value(forKey: "year") as! Int
//
//                    books?.append(Book(title: title, author: author, pages: pages, year: year))
//                }
//            }
//
        } catch {
            print(error)
        }
    }
    

}

