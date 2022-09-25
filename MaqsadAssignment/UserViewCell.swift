//
//  UserViewCell.swift
//  MaqsadAssignment
//
//  Created by Bisma Soomro on 24/09/2022.
//

import UIKit
import SDWebImage

class UserViewCell: UITableViewCell {
    
    @IBOutlet weak var typeTitlelLbl: UILabel!
    @IBOutlet weak var loginTitleLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var responseItem: Items?{
        didSet{
            loginTitleLbl.text = responseItem?.login
            typeTitlelLbl.text = responseItem?.type
            userImageView.sd_setImage(with: URL(string: responseItem?.avatar_url ?? ""), placeholderImage: UIImage(systemName: "person.fill" ), options: .allowInvalidSSLCertificates, context: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
