//
//  ViewController.swift
//  Cats-Fact
//
//  Created by omrobbie on 23/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        NetworkManager().getRandomFact { (text) in
            DispatchQueue.main.async {
                self.lblText.text = text
            }
        }
    }

    @IBAction func btnRandomTapped(_ sender: Any) {
        loadData()
    }
}
