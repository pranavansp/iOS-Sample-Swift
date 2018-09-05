//
//  ListViewCell.swift
//  AppAsign
//
//  Created by Pranavan on 7/14/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import UIKit
import SDWebImage

class ListViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var listimage: UIImageView!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var firstLetterLabel: UILabel!
    
    var article : Article?{
        didSet{
            if let titleName = article?.title{
                self.title.text = titleName
                if let firstLetter = titleName.first{
                    self.firstLetterLabel.text = "\(firstLetter)"
                }
            }
            if let image = article?.urlToImage{
                if let url = URL(string:image){
                    listimage.isHidden = false
                    listimage.sd_setShowActivityIndicatorView(true)
                    listimage.sd_setIndicatorStyle(.gray)
                    listimage.sd_setImage(with: url)
                }else{
                    listimage.isHidden = true
                }
            }
            if let source = article?.source?.name{
                self.source.text = source
            }
            if let desc = article?.desc{
                self.desc.text = desc
            }
        }
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        self.listimage.layer.cornerRadius = 5.0
        self.listimage.clipsToBounds = true
        self.firstLetterLabel.layer.cornerRadius = 5.0
        self.firstLetterLabel.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
