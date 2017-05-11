//
//  ViewController.swift
//  workout
//
//  Created by James Chen on 06/05/2017.
//  Copyright © 2017 James Chen. All rights reserved.
//

import UIKit

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var picker: UIPickerView!
    let screen = UIScreen.main.bounds.size
    
    override func viewDidLoad(){
        let content = ["Bench press", "Squat", "Deadlift", "Pac dec"]
        picker = UIPickerView(
            frame: CGRect(x: 0, y: 0, width:screen.width, height: 100)
        )
        picker.dataSource(content)
        picker.reloadAllComponents()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 結束編輯 把鍵盤隱藏起來
        self.view.endEditing(true)
        
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


