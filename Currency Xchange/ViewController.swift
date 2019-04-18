//
//  ViewController.swift
//  Currency Xchange
//
//  Created by Lin Hoang on 6/14/18.
//  Copyright © 2018 Lin Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var eurLabel: UILabel!
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var vndLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.delegate = self

        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getCurrency(currency: searchBar.text!)
        searchBar.text = ""
    }
    
    func getCurrency(currency: String){
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=6e576c693ecd571080be648e2bb6ea81&base=eur")
      let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if  error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
                
            }else{
                if data != nil{
                    do{
                        
                          let jSONResult = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,AnyObject>
                        
                        DispatchQueue.main.async {
                            print(jSONResult)
                            
                            let rates = jSONResult["rates"] as! [String: AnyObject]
                            
                            let usd = String(describing: rates["USD"]!)
                            self.usdLabel.text = "USD: \(usd)"
                            
                            let eur = String(describing: rates["EUR"]!)
                            self.eurLabel.text = "EUR: \(eur)"
                            
                            let vnd = String(describing: rates["VND"]!)
                            self.vndLabel.text = "VND: \(vnd)"
                            
                            
                        }
                        
                    }catch{
                        
                    }
                    
                  
                }
            }
        }
         task.resume()
    }
    
}

