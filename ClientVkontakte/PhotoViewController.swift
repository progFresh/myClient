//
//  PhotoViewController.swift
//  ClientVkontakte
//
//  Created by Сергей Полозов on 06.02.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {

    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var via: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeLabel.textColor = .blue
        repostLabel.textColor = .blue
        imageView.sd_setImage(with: URL(string: via[0]))
        likeLabel.text = ("likes: \(via[1])")
        repostLabel.text = ("reposts: \(via[2])")
    }

}
