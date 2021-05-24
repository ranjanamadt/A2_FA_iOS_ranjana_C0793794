//
//  AddEditProductVC.swift
//  A2_FA_iOS_ranjana_C0793794
//
//  Created by Ranjana on 23/05/21.
//

import UIKit
import CoreData

protocol saveData {
    func  updateProduct(pId : Int , pName : String , pDes : String , pPrice :Double ,pProvider :String)
    func deleteProduct(product: Product)
    func deleteProvider(provider: Providers)
}

class AddEditProductVC: UIViewController {

    
    @IBOutlet weak var textFieldProductName: UITextField!
    
    @IBOutlet weak var textFieldProductId: UITextField!
    
    @IBOutlet weak var textFieldProvider: UITextField!
    
    @IBOutlet weak var textFieldPrice: UITextField!
    
    @IBOutlet weak var textFieldDescription: UITextField!
    
    var managedContext: NSManagedObjectContext!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var products: [Product]?
   
    var selectedProduct: Product?{
        didSet {
            editMode = true
        }
    }
    // edit mode by default is false
    var editMode: Bool = false
    
    var  delegate : saveData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = appDelegate.persistentContainer.viewContext
        
        if(selectedProduct != nil){
        //Set Selected Product Data in textFields
        textFieldProductId.text =  String (selectedProduct!.productId)
        textFieldProductName.text = selectedProduct?.productName
            textFieldProvider.text = selectedProduct?.provider?.providerName
        textFieldDescription.text = selectedProduct?.productDescription
        textFieldPrice.text =  String (selectedProduct!.productPrice)
        
        
        }
      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        selectedProduct=nil
    }
 
    @IBAction func onCancelClick() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
      
            if editMode {
                self.delegate?.deleteProduct(product:  selectedProduct!)
                self.delegate?.deleteProvider(provider: (selectedProduct?.provider)!)
            }
        
      
        let proId = Int (textFieldProductId.text ?? "0") ??  0
        let proName = textFieldProductName.text ?? ""
        let proPrice = Double (textFieldPrice.text ?? "0.0") ?? 0.0
        let proDescription = textFieldDescription.text ?? ""
        let proProvider = textFieldProvider.text ?? ""
        
        
        if (proId != 0 || proName != "" || proPrice != 0 || proProvider != "" || proDescription != ""){
    
            self.delegate?.updateProduct(pId: proId, pName: proName, pDes: proDescription, pPrice: proPrice, pProvider: proProvider)
        }
      
        self.dismiss(animated: false, completion: nil)
      
    }
    
//    func updateProduct(pId : Int , pName : String , pDes : String , pPrice :Double ,pProvider :String  ) {
//      //  products = []
//
//        let pnewProduct = Providers(context: context)
//        pnewProduct.providerName=pProvider
//
//        let newProduct = Product(context: context)
//       // newNote.title = title
//        //newNote.parentFolder = selectedFolder
//        newProduct.productId = Int32(pId)
//        newProduct.productName = pName
//        newProduct.productPrice = pPrice
//        newProduct.productDescription = pDes
//        newProduct.provider = pnewProduct
//
//        do {
//            managedContext = appDelegate.persistentContainer.viewContext
//            try managedContext.save()
//        } catch {
//            print(error)
//        }
//
//    }
//
//    //MARK:- Delete Product from Core Data
//    func deleteProduct(product: Product) {
//        context.delete(product)
//    }
//    
   
    
}
