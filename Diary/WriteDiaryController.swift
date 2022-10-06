//
//  WriteDiaryController.swift
//  Diary
//
//  Created by admin on 2022/10/06.
//

import UIKit

class WriteDiaryController: UIViewController {

  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var contentsTextView: UITextView!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var confirmButton: UIBarButtonItem!
  
  private let datePicker=UIDatePicker()
  private var diaryDate:Date?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureContentsTextView()
    self.configureDatePicker()
    self.configureInputField()
    self.confirmButton.isEnabled=false
  }
  
  private func configureContentsTextView(){
    let borderColor=UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
    self.contentsTextView.layer.borderColor=borderColor.cgColor
    self.contentsTextView.layer.borderWidth=0.5
    self.contentsTextView.layer.cornerRadius=5.0
  }
  private func configureDatePicker(){
    self.datePicker.datePickerMode = .date
    self.datePicker.preferredDatePickerStyle = .wheels
    self.datePicker.addTarget(self,action: #selector(datePickerValueDidChange(_:)),for:.valueChanged)
    self.datePicker.locale=Locale(identifier: "ko-KR")
    self.dateTextField.inputView=self.datePicker
  }
  private func configureInputField(){
    self.contentsTextView.delegate=self
    self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
    self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
  }
  @IBAction func tapConformButton(_ sender: UIBarButtonItem) {

  }
  @objc private func datePickerValueDidChange(_ datePicker:UIDatePicker){
    let formmter=DateFormatter()
    formmter.dateFormat="yyyy 년 MM월 dd일 (EEEEE)"
    formmter.locale=Locale(identifier: "ko_KR")
    self.diaryDate=datePicker.date
    self.dateTextField.text=formmter.string(from: datePicker.date)
    self.dateTextField.sendActions(for: .editingChanged)
  }
  
  @objc private func titleTextFieldDidChange(_ textField:UITextField){
    self.validateInputField()
  }
  
  @objc private func dateTextFieldDidChange(_ textField:UITextField){
    self.validateInputField()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  private func validateInputField(){
    self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ??  true) &&
      !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
  }
  
}

extension WriteDiaryController:UITextViewDelegate{
  func textViewDidChange(_ textView:UITextView){
    self.validateInputField()
  }
}
