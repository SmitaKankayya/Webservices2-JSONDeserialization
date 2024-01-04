//
//  DataDetailsViewController.swift
//  Webservices2-JSON_Deserialization
//
//  Created by Smita Kankayya on 02/01/24.
//

import UIKit

class DataDetailsViewController: UIViewController {
    
    @IBOutlet weak var dataId: UILabel!
    @IBOutlet weak var dataFirst_Name: UILabel!
    @IBOutlet weak var dataAvatarImage: UIImageView!
    
    var dataContainer : Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    func bindData(){
        self.dataId.text = String(dataContainer!.id)
        self.dataFirst_Name.text = dataContainer?.first_name
        dataAvatarImage.kf.setImage(with: URL(string: dataContainer!.avatar))
    }
}
