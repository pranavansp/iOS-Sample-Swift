//
//  ViewController.swift
//  AppAsign
//
//  Created by Pranavan on 7/14/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import UIKit

class FullViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleValue: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var source: UILabel!
    
    var article = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDetilsView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func loadDetilsView(){
        if let imageURL = self.article.urlToImage{
            if let url = URL(string:imageURL){
                mainImage.isHidden = false
                mainImage.sd_setShowActivityIndicatorView(true)
                mainImage.sd_setIndicatorStyle(.gray)
                mainImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "picture"))
            }else{
                mainImage.isHidden = true
            }
        }
        self.titleValue.text = self.article.title
        self.desc.text = self.article.desc
        self.source.text = self.article.source.name
        self.title = self.article.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

