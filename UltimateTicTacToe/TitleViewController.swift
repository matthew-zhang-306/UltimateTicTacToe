//
//  TitleViewController.swift
//  UltimateTicTacToe
//
//  Created by Bellefeuille, Neo M on 4/17/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    override func viewDidLoad() {
       super.viewDidLoad()
        let imageName = "X.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: startSpot(), y: 0, width: 100, height: 200)
        view.addSubview(imageView)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // width is 1024

    func startSpot() -> Int
    {
        return Int(arc4random_uniform(UInt32(1024)))
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
