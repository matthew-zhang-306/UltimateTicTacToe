//
//  WinScreenViewController.swift
//  UltimateTicTacToe
//
//  Created by Le, Brandon M on 5/10/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import UIKit

class WinScreenViewController: UIViewController
{
    @IBOutlet weak var WinnerLabel: UILabel!
    
    var winner: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        WinnerLabel.text = "\(winner!) won the game!"
    }
    
    @IBAction func newGame(_ sender: Any)
    {
        performSegue(withIdentifier: "ReplaySegue", sender: self)
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
