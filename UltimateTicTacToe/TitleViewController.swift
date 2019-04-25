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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // width is 1024
    
    
    func createAnimateShape()
    {
        let imageName = chooseShape()
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: startSpot(), y: -50, width: 100, height: 100)
        if imageName == "X.png" {
            imageView.alpha = CGFloat(0.5)
        }
        if imageName == "O.png" {
            imageView.alpha = CGFloat(0.5)
        }
        view.addSubview(imageView)
        
        UIImageView.animate(withDuration: chooseSpeed(), animations: {imageView.frame.origin.y += 1416})
    }
    func chooseShape() -> String
    {
        let x = Int(arc4random_uniform(UInt32(2)))
        if x == 2 {
            return "X.png"
        }
        if x == 1 {
            return "O.png"
        }
        return "X.png"
    }
    func startSpot() -> Int
    {
        return Int(arc4random_uniform(UInt32(1024)))
    }
    func chooseSpeed() -> Double
    {
        return Double(Int(arc4random_uniform(UInt32(15))))
    }
    func run()
    {
        createAnimateShape()
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
