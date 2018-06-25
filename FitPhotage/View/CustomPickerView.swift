//
//  PickerView.swift
//  FitPhotage
//
//  Created by Weston Mauz on 6/17/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class CustomPickerView: UIPickerView {
    var modelData: [String]!
    let customHeight: CGFloat = 50
}

extension CustomPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
}

extension CustomPickerView: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return customHeight
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight))
        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight))
        topLabel.textAlignment = .center
        topLabel.textColor = UIColor.black
        topLabel.text = modelData[row]
        view.addSubview(topLabel)
        return view
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if row == 0 {
//            pickerView.isHidden = true
//        }
//    }
    
}
