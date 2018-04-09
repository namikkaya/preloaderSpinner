//
//  ViewController.swift
//  preloaderSpinner
//
//  Created by namik kaya on 6.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, preloaderDelegate {
    var pre:preloader!
    var request:Request?
    
    private var data:allDatesData?
    
    private var path:String = "http://www.millipiyango.gov.tr/sonuclar/listCekilisleriTarihleri.php"
    
    /// Preloader kapatıldığı an cevap döner. preloaderDelegate
    func preloaderClosed() {
        if (pre != nil){
            pre = nil
        }
        showDataTable()
    }
    
    func showDataTable() {
        let sVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! secondViewController
        sVC.data = self.data
        //self.present(sVC, animated: true)
        self.navigationController?.pushViewController(sVC, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (pre != nil){
            pre = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func openSpinner(){
        pre = preloader()
        pre.delegate = self
        pre.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        pre.trackerColor = UIColor.clear
        pre.cSpinnerColor = UIColor.red
        pre.aSpinnerColor = UIColor.blue
        pre.bSpinnerColor = UIColor.yellow
        pre.begin()
    }
    
    private func closeSpinner(){
        if (self.pre) != nil {
            self.pre.close()
        }
    }
    
    @IBAction func popUP(_ sender: Any) {
        self.openSpinner()
        // ALAMOFIRE
        request = Alamofire.request(path, method: HTTPMethod.post, parameters: ["tur":"sayisal"], encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            // veri döndüğünde preloaderSpinner kapatılcak
            self.closeSpinner()
            
            switch response.result {
            case .success:
                do {
                    let _data = try JSONSerialization.data(withJSONObject: response.result.value ?? NSArray(), options: [])
                    let dt = try JSONDecoder().decode([dateData].self, from: _data)
                    self.data = allDatesData(data: dt)
                } catch {
                    print("problem")
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    //HANDLE TIMEOUT HERE
                }
                print("\n\nAuth request failed with error:\n \(error)")
                break
            }
            
        })
    }
}

