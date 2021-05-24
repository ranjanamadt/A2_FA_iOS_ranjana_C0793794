//
//  ViewController.swift
//  A2_FA_iOS_ranjana_C0793794
//
//  Created by Ranjana on 23/05/21.
//

import UIKit
import CoreData

class ListingVC:  UITableViewController{
 
    
    var products = [Product]()
    var managedContext: NSManagedObjectContext!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var table: UITableView!
    // define a search controller
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = appDelegate.persistentContainer.viewContext
        
        // Save Intial List of 10 Products in Core Data
        saveProductsInCoreData()
        
        // Load Saved list from Core Data and save it in products array
        loadProductsFromCoreData()
        
        showSearchBar()
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // If View is appeared then redirect to Product Detail with product stored at 0 position in products
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! AddEditProductVC
        nextViewController.selectedProduct = products[0]
        self.present(nextViewController, animated:true, completion:nil)
    }
 
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdCell")

        cell?.textLabel?.text = product.productName
        cell?.detailTextLabel?.text = product.productDescription
        cell?.detailTextLabel?.textColor = .darkGray

        return cell!
    }
    
    // Override to to delete row the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            deleteProduct(product : products[indexPath.row] )
            saveProductsInCoreData()
            loadProductsFromCoreData()
            products.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func loadProductsFromCoreData() {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            products = try managedContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    //MARK:- Delete Product from Core Data
    func deleteProduct(product: Product) {
        context.delete(product)
    }
    
    //MARK: - Show Search Bar to serach products from listing
    func showSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Product"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = .black
        table.tableHeaderView = searchController.searchBar
    }


   
    @objc func saveProductsInCoreData() {
        clearCoreData()
      
        var newProduct = Product(context: context)
        newProduct.productId=1
        newProduct.productName="TV"
        newProduct.productPrice=56.00
        newProduct.productProvider="Samsung"
        newProduct.productDescription="Screen Size 24'', Resolution 720P"
        
       
        newProduct = Product(context: context)
        newProduct.productId=2
        newProduct.productName="Headphones"
        newProduct.productPrice=30.00
        newProduct.productProvider="Samsung"
        newProduct.productDescription="Wireless Bluetooth , Active Noise Cancellation"
        
        newProduct = Product(context: context)
        newProduct.productId=3
        newProduct.productName="Laptop"
        newProduct.productPrice=89.00
        newProduct.productProvider="HP"
        newProduct.productDescription="8GB RAM, Intel Core i7 Processor ,1TB HDD"
        
        newProduct = Product(context: context)
        newProduct.productId=4
        newProduct.productName="Speakers"
        newProduct.productPrice=25.50
        newProduct.productProvider="Boat"
        newProduct.productDescription="Wireless Bluetooth , Battery Life 10 Hrs"
        
        newProduct = Product(context: context)
        newProduct.productId=5
        newProduct.productName="Speakers"
        newProduct.productPrice=23.50
        newProduct.productProvider="JBL"
        newProduct.productDescription="Mounting type Table Top , Portable Speaker"
        
        newProduct = Product(context: context)
        newProduct.productId=6
        newProduct.productName="Hark Disk"
        newProduct.productPrice=45.50
        newProduct.productProvider="HP"
        newProduct.productDescription="Storage 1TB, Interface USB 3.0, Read Speed 120MB"
        
        newProduct = Product(context: context)
        newProduct.productId=7
        newProduct.productName="Pen Drive"
        newProduct.productPrice=10.50
        newProduct.productProvider="HP"
        newProduct.productDescription="Space 18 GB, Weight 50g"
        
        newProduct = Product(context: context)
        newProduct.productId=8
        newProduct.productName="Smart Watch"
        newProduct.productPrice=70.00
        newProduct.productProvider="Apple"
        newProduct.productDescription="Measure SPO2 level, Black Color, 1.3''"
        
        newProduct = Product(context: context)
        newProduct.productId=9
        newProduct.productName="Camera"
        newProduct.productPrice=60.00
        newProduct.productProvider="Sony"
        newProduct.productDescription="Alpha A7 Mirrorless Digital Camera "
        
        newProduct = Product(context: context)
        newProduct.productId=10
        newProduct.productName="Keyboard"
        newProduct.productPrice=10.50
        newProduct.productProvider="Apple"
        newProduct.productDescription="Instant one touch, Noiseless and Smooth, UV Coated Keys"
        
        
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
        
        
        
        
    }
    
    //MARK:-Override prepare method to send selectd product to Detail Product View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddEditProductVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedProduct = products[indexPath.row]
        }
    }
    
    // MARK:- Method to clear Core Data
    func clearCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                if let managedObject = result as? NSManagedObject {
                    managedContext.delete(managedObject)
                }
            }
        } catch {
            print("Error deleting records \(error)")
        }
        
    }
    
    /// Load Products from Core Data based on serach
    /// - Parameter predicate: parameter comming from search bar - by default is nil
    func loadSearchedProducts(predicate: NSPredicate? = nil) {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate=predicate
        do {
            products = try context.fetch(request)
        } catch {
            print("Error loading products \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
}

//MARK: - search bar delegate methods
extension ListingVC: UISearchBarDelegate {

    /// search button on keypad functionality
    /// - Parameter searchBar: search bar is passed to this function
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Predicate for product name and description
        let predicate = NSPredicate(format: "productName CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@", searchBar.text!,searchBar.text!)

        loadSearchedProducts(predicate: predicate)
    }
    
    
     // MARK:- When Text in search bar changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadSearchedProducts()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

