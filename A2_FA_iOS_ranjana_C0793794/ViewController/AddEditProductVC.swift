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

        
        //Set Selected Product Data in textFields
        textFieldProductId.text =  String (selectedProduct!.productId)
        textFieldProductName.text = selectedProduct?.productName
        textFieldProvider.text = selectedProduct?.productProvider
        textFieldDescription.text = selectedProduct?.productDescription
        textFieldPrice.text =  String (selectedProduct!.productPrice)
      
    }
 
    @IBAction func onCancelClick() {
        self.dismiss(animated: false, completion: nil)
    }
    
 
}
