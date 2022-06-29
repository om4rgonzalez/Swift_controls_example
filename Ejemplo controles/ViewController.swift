//
//  ViewController.swift
//  Ejemplo controles
//
//  Created by Omar Gonzalez on 21/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    @IBOutlet weak var myPageControll: UIPageControl!
    
    @IBOutlet weak var MySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var mySlider: UISlider!
    
    @IBOutlet weak var mySteper: UIStepper!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var myProgressView: UIProgressView!
    
    @IBOutlet weak var myLabelSwitch: UILabel!
    
    @IBOutlet weak var myProgresIndiucator: UIActivityIndicatorView!
    
    @IBOutlet weak var myLabelStep: UILabel!
    
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var myTextView: UITextView!
    // variables
    
    private let myPickerViewValues = ["uno", "dos", "tres", "cuatro", "cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // buttons
        myButton.setTitle("Primer Boton", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
        // pickers
        myPickerView.backgroundColor = .lightGray
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.isHidden = true
        
        // page control
        myPageControll.numberOfPages = myPickerViewValues.count
        myPageControll.currentPageIndicatorTintColor = .blue
        myPageControll.pageIndicatorTintColor = .lightGray
        
        // segmented controll
        MySegmentedControl.removeAllSegments()
        for(index, value) in myPickerViewValues.enumerated(){
            MySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // Slider
        mySlider.minimumTrackTintColor = .red
        mySlider.maximumTrackTintColor = .blue
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        
        // Steper
        mySteper.minimumValue = 1
        mySteper.maximumValue = Double(myPickerViewValues.count)
        
        // Switch
        mySwitch.onTintColor = .purple
        mySwitch.isOn = false
        
        // progress indicator
        myProgressView.progress = 0
        myProgresIndiucator.color = .orange
        myProgresIndiucator.startAnimating()
        myProgresIndiucator.hidesWhenStopped = true
        
        // labels
        myLabelStep.textColor = .darkGray
        myLabelStep.font = UIFont.boldSystemFont(ofSize: 36)
        myLabelStep.text = "1"
        
        myLabelSwitch.text = "Esta apagado"
        
        // TextField
        myTextField.textColor = .brown
        myTextField.placeholder = "Escribe algo"
        myTextField.delegate = self
        
        // TextView
        myTextView.textColor = .brown
        myTextView.delegate = self
        
    }
    
    
    @IBAction func ButtonClicked(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
        }
        else {
            myButton.backgroundColor = .blue
        }
        
        myTextView.resignFirstResponder()
    }
    
    @IBAction func myPageControllAction(_ sender: Any) {
        myPickerView.selectRow(myPageControll.currentPage, inComponent: 0, animated: true)
        myButton.setTitle(myPickerViewValues[myPageControll.currentPage], for: .normal)
        MySegmentedControl.selectedSegmentIndex = myPageControll.currentPage
    }
    
    
    @IBAction func mySegmentedControlAction(_ sender: Any) {
        myPickerView.selectRow(MySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        myButton.setTitle(myPickerViewValues[MySegmentedControl.selectedSegmentIndex], for: .normal)
        myPageControll.currentPage = MySegmentedControl.selectedSegmentIndex
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        var progress: Float = 0
        switch mySlider.value {
        case 1..<2:
            progress = 0.2
            setPosition(value: 0)
        case 2..<3:
            progress = 0.4
            setPosition(value: 1)
        case 3..<4:
            progress = 0.6
            setPosition(value: 2)
        case 4..<5:
            progress = 0.8
            setPosition(value: 3)
        default:
            progress = 1
            setPosition(value: 4)
        }
        
        myProgressView.progress = progress
    }
    
    @IBAction func mySteperAction(_ sender: Any) {
        mySlider.value = Float(mySteper.value)
        myLabelStep.text = "\(mySteper.value)"
        switch mySteper.value {
        case 1..<2:
            setPosition(value: 0)
        case 2..<3:
            setPosition(value: 1)
        case 3..<4:
            setPosition(value: 2)
        case 4..<5:
            setPosition(value: 3)
        default:
            setPosition(value: 4)
        }
    }
    
    
    @IBAction func mySwitchAction(_ sender: Any) {
        if mySwitch.isOn {
            myPickerView.isHidden = false
            myProgresIndiucator.stopAnimating()
        }
        else {
            myPickerView.isHidden = true
            myProgresIndiucator.startAnimating()
        }
    }
    
    
    
    
    func setPosition(value: Int){
        myPickerView.selectRow(value, inComponent: 0, animated: true)
        myButton.setTitle(myPickerViewValues[value], for: .normal)
        myPageControll.currentPage = value
        MySegmentedControl.selectedSegmentIndex = value
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        myPageControll.currentPage = row
    }
    
    
    
    
    
}

// UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(myTextField.text, for: .normal)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextField.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false
    }
}
