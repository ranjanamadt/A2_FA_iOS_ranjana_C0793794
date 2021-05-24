//
//  ProviderCell.swift
//  A2_FA_iOS_ranjana_C0793794
//
//  Created by one on 24/05/21.
//

import UIKit

class ProviderCell: UITableViewCell {

    @IBOutlet weak var lblProviderName: UILabel!
    @IBOutlet weak var lblProviderCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //this function to show values of the selected product in the cell columns
    func setProviderCell (provider: Providers){
        
           
       lblProviderName.text=provider.providerName
       
        
        
    }


}
