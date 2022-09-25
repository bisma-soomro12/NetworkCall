//
//  ViewController.swift
//  MaqsadAssignment
//
//  Created by Bisma Soomro on 23/09/2022.
//

import UIKit

class SearchComponentVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchTxt: UITextField!
    var responseData: ResponseData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxt.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchTxt.text = ""
        
       
    }
    
    // MARK: - submitBtnDidTap()
    @IBAction func submitBtnDidTap(_ sender: Any) {
        if searchTxt.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Empty String can't be allowd", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let search = searchTxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
        apiCall(search: search)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "ResultComponentVC") as? ResultComponentVC{
                vc.responseData = self.responseData
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        })    }
    
    // MARK: - apiCall()
    func apiCall(search: String){
        let urlString = "https://api.github.com/search/users?q=\(search)%20in:login"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let responseDetail = try decoder.decode(ResponseData.self, from: data)
                    self.responseData = responseDetail
                } catch let err{
                    print(err)
                }
            }
          
        }.resume()
    }
    
    // MARK: - handleKeyboardNotification()
    @objc func handleKeyboardNotification(notification: NSNotification){
        if let userInfo = notification.userInfo {
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            if isKeyboardShowing {
                print("Keyboard Showing")
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 20  , right: 0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            } else {
                print("Keyboard Hidden")
                scrollView.contentInset = .zero
                scrollView.scrollIndicatorInsets = .zero
            }
            view.layoutIfNeeded()
        }
    }
}

// MARK: - extension: UITextFieldDelegate
extension  SearchComponentVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UIView
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
