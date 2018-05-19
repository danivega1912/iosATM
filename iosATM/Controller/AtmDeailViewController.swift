//
//  AtmDeailViewController.swift
//  iosATM
//
//  Created by Daniel Vega on 5/19/18.
//  Copyright © 2018 Daniel Vega. All rights reserved.
//

import UIKit

class AtmDeailViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var operationHoursLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var depositsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var networkImage: UIImageView!
    @IBOutlet weak var backInfoView: UIView!
    var atm:Atm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //round corners
        closeButton.layer.cornerRadius = 10
        backInfoView.layer.cornerRadius = 10
        //fill info
        addressLabel.text = atm.getAddress()
        operationHoursLabel.text = atm.getOpenHours()
        moneyLabel.text = atm.getHasMoney() ? "Has Money" : "No money"
        depositsLabel.text = atm.getAcceptDeposits() ? "Accept Deposits" : "No Deposits"
        statusLabel.text = atm.getStatus()
        networkImage.image = UIImage(named: atm.getNetwork())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        //close this view
        self.dismiss(animated: true, completion:nil)
    }
}
