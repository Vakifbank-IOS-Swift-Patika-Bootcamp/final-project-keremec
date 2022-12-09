//
//  ViewController.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 9.12.2022.
//

import UIKit

class HomeSceneViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = NSLocalizedString("HOME_SCREEN_LABEL", comment: "test comment")
        
    }


}

