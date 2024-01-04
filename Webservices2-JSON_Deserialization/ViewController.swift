//
//  ViewController.swift
//  Webservices2-JSON_Deserialization
//
//  Created by Smita Kankayya on 02/01/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var dataCollectionView: UICollectionView!
    
    private let dataCollectionViewCellIdentifire = "DataCollectionViewCell"
    var dataDetailsViewController : DataDetailsViewController?
    
    var url : URL?
    var urlRequest : URLRequest?
    var user = User(data: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerWithXIBTableView()
        initializeTableView()
        jsonParsingUsingDecoder()
    }
    
    func  registerWithXIBTableView(){
        let uiNib = UINib(nibName: dataCollectionViewCellIdentifire, bundle: nil)
        self.dataCollectionView.register(uiNib, forCellWithReuseIdentifier: dataCollectionViewCellIdentifire)
    }
    
    func initializeTableView(){
        dataCollectionView.dataSource = self
        dataCollectionView.delegate = self
    }
    
    func jsonParsingUsingDecoder(){
        url = URL(string: "https://reqres.in/api/users?page=2")
        urlRequest = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest!) { data, response, error in
            let jsonDecoder = JSONDecoder()
            
            self.user = try! jsonDecoder.decode(User.self, from: data!)
            
            print(self.user)
            
            DispatchQueue.main.async {
                self.dataCollectionView.reloadData()
            }
        }
        dataTask.resume()
    }
}

//MARK : UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        user.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataCollectionViewCell = self.dataCollectionView.dequeueReusableCell(withReuseIdentifier: dataCollectionViewCellIdentifire, for: indexPath) as? DataCollectionViewCell
        dataCollectionViewCell?.dataIdLabel.text = String(user.data[indexPath.row].id)
        dataCollectionViewCell?.dataFirstNameLabel.text = user.data[indexPath.row].first_name
        dataCollectionViewCell?.dataAvatar.kf.setImage(with: URL(string: user.data[indexPath.row].avatar))
        return dataCollectionViewCell!
    }
}

//MARK : UICollectionViewDelegate
extension ViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DataDetailsViewController") as? DataDetailsViewController
        dataDetailsViewController?.dataContainer = user.data[indexPath.row]
        navigationController?.pushViewController(dataDetailsViewController!, animated: true)
    }
}

//MARK : UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
}
