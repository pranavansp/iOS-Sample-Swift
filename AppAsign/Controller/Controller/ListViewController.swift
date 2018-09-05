//
//  ListViewController.swift
//  AppAsign
//
//  Created by Pranavan on 7/14/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    enum FetchError : Error {
        case ResponseFaild
        case Invalid
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var articles = [Article]()
    var resp = REST()

    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        do{
            try fetchListFromServer()
        }catch FetchError.ResponseFaild{
            print("error ResponseFaild")
        }catch FetchError.Invalid{
            print("error Invalid")
        }catch{
            print("Unknow")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        /*switch segmentControll.selectedSegmentIndex
        {
        case 0:
            fetchListFromServer(country: "us", category: "business")
        case 1:
            fetchListFromServer(country: "us", category: "sports")
        case 2:
            fetchListFromServer(country: "us", category: "entertainment")
        default:
            break
        }*/
    }
    
    func fetchListFromServer(country:String = "us" ) throws {
        self.showActivityIndicator(uiView: self.view)
        
        if country.isEmpty{ throw FetchError.Invalid }
        
        NetworkingService.shared.getFrom(url: "/top-headlines?country=\(country)&category=business&apiKey=\(apiKey)") { (data, success) in
            if success {
                do{
                    let decoder = JSONDecoder()
                    self.resp = try decoder.decode(REST.self, from: data)
                    if let value = self.resp.articles{
                        self.articles = value
                    }
                    self.tableView.reloadData()
                }catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }catch{
                    print("Unknow")
                }
            }else{
                print("Faild at get")
            }
            self.tableView.reloadData()
            self.hideActivityIndicator(uiView: self.view)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullNewsView"{
            if let toSelectionVC = segue.destination as? FullViewController{
                let article = sender as! Article
                toSelectionVC.article = article
            }
        }
    }
    
    
}

extension ListViewController{
    //MARK: - Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        
        cell.article = self.articles[indexPath.item]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = self.articles[indexPath.item]
        performSegue(withIdentifier: "fullNewsView", sender: sender)
    }
}

//MARK:- Activity Indicator
extension ListViewController{
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40.0, height: 40.0)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}


