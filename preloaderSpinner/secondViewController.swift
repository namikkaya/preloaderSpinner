//
//  secondViewController.swift
//  preloaderSpinner
//
//  Created by namik kaya on 7.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class secondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, percentagePreloaderDelegate {
    // preloader object
    var perPre:percentagePreloader!
    var request:Request?
    
    public var data:allDatesData?
    
    @IBOutlet weak var tableView: UITableView!
    private var cellColorMan:cellColorManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        cellColorMan = cellColorManager()
        tableViewSetup()
    }
    
    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 44;
        tableView.rowHeight = UITableViewAutomaticDimension
        let edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.contentInset = edgeInsets
        let nib = UINib(nibName: "basicCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "basicCell")
        self.tableView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //------------------------------ TableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:basicCell = (tableView.cellForRow(at: indexPath) as? basicCell)!
        cell.setSelected(true, animated: true)
        cell.setHighlighted(true, animated: true)
        cell.backgroundColor = UIColor.init(hex: "#f4f4f4", alpha: 1)
        
        loadImage()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:basicCell = (tableView.cellForRow(at: indexPath) as? basicCell)!
        cell.setSelected(false, animated: true)
        cell.setHighlighted(false, animated: true)
        cell.backgroundColor = UIColor.init(hex: "#ffffff", alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:basicCell = (cell as? basicCell)!
        if(!cell.isSelected){
            cell.setSelected(false, animated: true)
            cell.setHighlighted(false, animated: true)
            cell.backgroundColor = UIColor.init(hex: "#ffffff", alpha: 1)
        }else{
            cell.setSelected(true, animated: true)
            cell.setHighlighted(true, animated: true)
            cell.backgroundColor = UIColor.init(hex: "#f4f4f4", alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath) as! basicCell
        cell.titleText.text = self.data?.data![row].tarihView
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.init(hex: "#ffffff", alpha: 1)
        cell.colorView.backgroundColor = cellColorMan.check(row: row, mod: 2)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var dataCount:Int = 0
        if let count = data?.data?.count {
            dataCount = count
        }
        return dataCount
    }
    // -------------------------------------------------TABLEVIEW
    
    var showImageHolder:UIImage!
    
    private func openSpinner(){
        perPre = percentagePreloader()
        perPre.delegate = self
        perPre.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        perPre.textColor = UIColor.white
        perPre.spinnerColor = UIColor.red
        perPre.trackkerColor = UIColor.white
        perPre.begin()
    }
    
    func loadImage(){
        openSpinner()
        Alamofire.request("https://www.hdwallpapers.in/walls/ferrari_laferrari_2017_4k-HD.jpg").downloadProgress(closure: { (progress) in
            
            if (self.perPre != nil) {
                self.perPre.percent = CGFloat(progress.fractionCompleted)
            }
            
        }).responseData { (response) in
            if let data = response.result.value {
                // close percent preloader after in the download complete
                self.showImageHolder = UIImage(data: data)
                self.perPre.close()
            }
            
        }
    }
    
    // percentagePreloader -> DELEGATE
    func percentagePreloaderClose() {
        perPre.delegate = nil
        perPre = nil
        let sVC = self.storyboard?.instantiateViewController(withIdentifier: "showImageVC") as! showImageViewController
        sVC.image = showImageHolder
        //self.present(sVC, animated: true)
        self.navigationController?.pushViewController(sVC, animated: true)
    }
    
}

extension UIColor {
    /// hex -> Color
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hex: "ff0000")
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

