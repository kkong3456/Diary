//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by admin on 2022/10/06.
//

import UIKit

protocol DiaryDetailViewDelegate:AnyObject{
  func didSelectDelete(indexPath:IndexPath)
}

class DiaryDetailViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var contentsTextView: UITextView!
  
  weak var delegate:DiaryDetailViewDelegate?
  
  var diary:Diary?
  var indexPath:IndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  private func configureView(){
    guard let diary=self.diary else {return}
    self.titleLabel.text=diary.title
    self.contentsTextView.text=diary.title
    self.contentsTextView.text=diary.contents
    self.dateLabel.text=self.dateToString(date: diary.date)
  }
  private func dateToString(date:Date)->String{
    let formatter=DateFormatter()
    formatter.dateFormat="yy년 MM월 dd일(EEEEEE)"
    formatter.locale=Locale(identifier: "ko_KR")
    return formatter.string(from:date)
  }
  
  @objc func editDiaryNotification(_ notification:Notification){
    guard let diary=notification.object as? Diary else {return}
    guard let row=notification.userInfo?["indexPath.row"] as? Int else {return}
    self.diary=diary
    self.configureView()
  }
  
  @IBAction func tapAddButton(_ sender: UIButton) {
    guard let viewController=self.storyboard?.instantiateViewController(identifier: "WriteDiaryController") as? WriteDiaryController else {return}
    
    guard let indexPath=self.indexPath else {return}
    guard let diary=self.diary else {return}
    viewController.diaryEditorMode = .edit(indexPath,diary)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(editDiaryNotification(_:)),
      name: NSNotification.Name("editDiary"),
      object: nil
    )
    self.navigationController?.pushViewController(viewController, animated: true)
    
  }
  
  @IBAction func tapDeleteButton(_ sender: UIButton) {
    guard let indexPath=self.indexPath else {return}
    self.delegate?.didSelectDelete(indexPath:indexPath)
    self.navigationController?.popViewController(animated: true)
  }
  
  deinit{
    NotificationCenter.default.removeObserver(self)
  }
  

}
