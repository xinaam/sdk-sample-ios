//
//  VideoPlayerViewController.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 17/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var viewVideoPlayer: UIView!
    @IBOutlet weak var buttonInitialize: UIButton!
    @IBOutlet weak var textFeildToken: PaddingTextField!
    var userId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    func configUI(){
        textFeildToken.text = userId
    }
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func buttoninitilize(_ sender: UIButton) {
    }
    @IBAction func buttonPauseAction(_ sender: UIButton) {
    }
    @IBAction func buttonPlayAction(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
