//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    let inDateFormatter = ISO8601DateFormatter()
    let outDateFormatter: DateFormatter = {
           let df = DateFormatter()
           df.dateFormat = "dd-MM-yyyy HH:mm:ss"
           return df
       }()
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var timeOfQuotation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

}

// MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    
    
    func didUpdateCoinPrice(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            
            let rate = String(format: "%.2f", coinModel.rate)
            self.bitcoinLabel.text = rate
            self.currencyLabel.text = coinModel.assetIDQuote
            
            let dateString = coinModel.time
            print(coinModel.time)
            let date = self.inDateFormatter.date(from: dateString)
            let formattedString = self.outDateFormatter.string(from: date ?? Date())
            self.timeOfQuotation.text = formattedString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
 
}

// MARK: - UIPickerViewDataSource and UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        
    }
}

