//
//  ViewController.swift
//  MeteoApp
//
//  Created by Gaia Magnani on 08/09/2017.
//  Copyright © 2017 Gaia Magnani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    var days: [Day]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.button.isEnabled = false
        self.startWeatherRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startWeatherRequest() {
        let service = ServiceRequesterDay(city: "Milano,it", numOfDays: 15)
        
        let errCompletionHandler = { (code: Int, s: String) -> Void in
            print("ERROR getting data from API")
            
            
            
        }
        
        let completionHandler = {
            self.days = service.days
            self.button.isEnabled = true
        }
        
        
        service.getDataWith(
            completionHandler: completionHandler,
            errCompletionHandler: errCompletionHandler)
    }
    

    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "weather" {
          
            let controller = (segue.destination as! UINavigationController).viewControllers[0] as! DaysTableViewController
            controller.daysToShow = self.days
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
 




}

