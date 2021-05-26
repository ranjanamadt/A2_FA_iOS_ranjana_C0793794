//
//  ProdCell.swift
//  A2_FA_iOS_ranjana_C0793794
//
//  Created by one on 24/05/21.
//

import UIKit

class ProdCell: UITableViewCell {

    @IBOutlet weak var lblProdName: UILabel!
    
    @IBOutlet weak var lblProdDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var prodPrice: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //this function to show values of the selected product in the cell columns
    func setProdCell (product: Product){
        lblProdName.text=product.productName
        lblProdDescription.text=product.provider?.providerName
        
        
    }

}
