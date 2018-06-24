//
//  PickerView.swift
//  FitPhotage
//
//  Created by Weston Mauz on 6/17/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class InformationPicker: UIPickerView {
    var modelData: Structure!
    let customHeight:CGFloat = 50
    let customWidth:CGFloat = 100
    let fontSize: CGFloat = 16
    let textColor:UIColor = UIColor.CustomColors.customDarkOrange
}

extension InformationPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
//        return modelData.blinds.count
    }
}

extension InformationPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return customHeight
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        topLabel.textAlignment = .center
        topLabel.textColor = textColor
        topLabel.text = modelData.gender[row]
        topLabel.font = UIFont.systemFont(ofSize: fontSize)
        view.addSubview(topLabel)
        view.layer.borderColor = UIColor.CustomColors.lead.cgColor
        view.layer.borderWidth = 2
        
        return view
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            pickerView.isHidden = true
        }
    }
    
}
