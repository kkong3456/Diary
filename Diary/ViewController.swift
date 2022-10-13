//
//  ViewController.swift
//  Diary
//
//  Created by admin on 2022/10/06.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var diaryList = [Diary]()

  override func viewDidLoad() {
   
    super.viewDidLoad()
    self.configureCollectionView()
    // Do any additional setup after loading the view.
  }
  
  private func configureCollectionView() {
    self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }
  
  private func dateToString(date:Date)->String{
    let formatter=DateFormatter()
    formatter.dateFormat="yy년 MM월 dd일(EEEEEE)"
    formatter.locale=Locale(identifier: "ko-KR")
    return formatter.string(from: date)
  }
  
  override func prepare(for segue:UIStoryboardSegue,sender:Any?){
    if let writeDiaryViewController=segue.destination as? WriteDiaryController{
      writeDiaryViewController.delegate=self
    }
  }
}

extension ViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    debugPrint(self.diaryList.count)
    return self.diaryList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else  { return UICollectionViewCell() }
    let diary=self.diaryList[indexPath.row]
    cell.titleLabel.text=diary.title
    cell.dateLabel.text=self.dateToString(date: diary.date)
    return cell
  }
}

extension ViewController:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (UIScreen.main.bounds.width/2-20), height: 200)
  }
}

extension ViewController:WriteDiaryViewDelegate{
  func didSelectRegister(diary:Diary){
    self.diaryList.append(diary)
    self.collectionView.reloadData()
  }
}


