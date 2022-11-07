//
//  ColorsDetailVC.swift
//  RandomColors
//
//  Created by João Madruga on 04/11/22.
//

import UIKit

class ColorsDetailVC: UIViewController {
    
    var color : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color ?? .blue
    }

}
