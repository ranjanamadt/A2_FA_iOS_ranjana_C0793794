//
//  AddEditProductVC.swift
//  A2_FA_iOS_ranjana_C0793794
//
//  Created by Ranjana on 23/05/21.
//

import UIKit
import CoreData

class AddEditProductVC: UIViewController {

    
    @IBOutlet weak var textFieldProductName: UITextField!
    
    @IBOutlet weak var textFieldProductId: UITextField!
    
    @IBOutlet weak var textFieldProvider: UITextField!
    
    @IBOutlet weak var textFieldPrice: UITextField!
    
    @IBOutlet weak var textFieldDescription: UITextField!
    
   
    var products: [Product]?
    var managedContext: NSManagedObjectContext!
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      //  textFieldProductId.text =  selectedProduct!.productId
        textFieldProductName.text = selectedProduct?.productName
        textFieldProvider.text = selectedProduct?.productProvider
        textFieldDescription.text = selectedProduct?.productDescription
       // textFieldPrice.text = NSString(format: ".2lf", selectedProduct?.productPrice as! "CVarArg")
        //textFieldPrice.text = String(format: ".2lf", selectedProduct?.productPrice)
    }
 
    @IBAction func onCancelClick() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onSaveClick() {
    }
    
    //MARK: - CoreData functions
    

    @objc func saveCoreData() {
        clearCoreData()
        for product in products! {
            let productEntity = NSEntityDescription.insertNewObject(forEntityName: "Product", into: managedContext)
            productEntity.setValue(product.productName, forKey: "productName")
            productEntity.setValue(product.productId, forKey: "productId")
            productEntity.setValue(product.productProvider, forKey: "productProvider")
            productEntity.setValue(product.productPrice, forKey: "productPrice")
            productEntity.setValue(product.productDescription, forKey: "productDescription")
        }
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func clearCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookModel")
//        fetchRequest.returnsObjectsAsFaults = false
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
}
