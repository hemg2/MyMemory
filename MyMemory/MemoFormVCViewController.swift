//
//  MemoFormVCViewController.swift
//  MyMemory
//
//  Created by 1 on 2022/07/03.
//

import UIKit

class MemoFormVCViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
   
    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var prevview: UIImageView!
    //저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save_(_ sender: Any) {
        // 내용을 입력하지 않았을 경우 ,경고한다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        //MemoData 객체를 생성하고, 데이터를 담는다.
        let data = MemoData()
        
        data.title = self.subject //제목
        data.contents = self.contents.text //내용
        data.image = self.prevview.image //이미지
        data.regdate = Date()  //작성 시각
        
        // 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //형 변환
        //appDelegate 창에 있는걸 가져온다??
        appDelegate.memoList.append(data)
        // 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick_(_ sender: Any) {
        //이미지 피커 인스턴스를 생성한다.
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: false)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지를 미리보기에 출력한다.
        self.prevview.image = info[.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        self.contents.delegate = self
    }
    //사용자가 텍스트 뷰에 뭔가를 입력하면 자동으로 이 메소드가 호출된다.
    func textViewDidChange(_ textView: UITextView) {
        // 내용 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //내비게이션 타이틀에 표시한다
        self.navigationItem.title = self.subject
    }
}
