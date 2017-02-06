//
//  CollectionViewController.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 02.02.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var arrayOfPhoto = [String]()
    var arrayOfLikes = [Int]()
    var arrayOfRepost = [Int]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfPhoto.removeAll()
        arrayOfLikes.removeAll()
        arrayOfRepost.removeAll()
        images.removeAll()
        
        collectionView?.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        let keyChain = KeyChain()
        let token = keyChain.getToken()
        fillCollectionView(token: token)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        viewDidLoad()
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let keyChain = KeyChain()
        keyChain.deleteToken()
        self.backToLoginViewController()
    }
    
    func setPhotos (settingPhotosUrl: [String]) {
        for index in 0...(settingPhotosUrl.count-1) {
            Alamofire.request(settingPhotosUrl[index]).responseImage { response in
                if let image = response.result.value {
                    self.images.append(image)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    func backToLoginViewController() {
        let theTransition = storyboard?.instantiateViewController(withIdentifier: "LoginID")
        present(theTransition!, animated: true, completion: nil)
    }
    
    func fillCollectionView (token: String) {
        Alamofire.request("https://api.vk.com/method/photos.getAll?extended=1&access_token=\(token)&v=5.62").responseJSON { response in
            if response.error != nil {
                self.title = "internet is off"
            } else if let result = response.result.value {
                let JSON = result as! NSDictionary
                if let dictionary = JSON.value(forKey: "response") as? NSDictionary {
                    let array = dictionary.value(forKey: "items") as! [NSDictionary]
                    for index in 0...(array.count-1) {
                        if let chek = array[index].value(forKey: "photo_604") as? String {
                            self.arrayOfPhoto.append(chek)
                            let likes = array[index].value(forKey: "likes") as! NSDictionary
                            self.arrayOfLikes.append(likes.value(forKey: "count") as! Int)
                            let reposts = array[index].value(forKey: "reposts") as! NSDictionary
                            self.arrayOfRepost.append(reposts.value(forKey: "count") as! Int)
                        }
                    }
                    self.setPhotos(settingPhotosUrl: self.arrayOfPhoto)
                   // print(self.arrayOfRepost.count)
                    //print(self.arrayOfLikes.count)
                    
                } else {
                    print("error of token")
                    self.backToLoginViewController()
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.image.image = images[indexPath.row]
        
        return cell
    }

}
