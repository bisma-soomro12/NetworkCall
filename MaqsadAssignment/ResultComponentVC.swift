//
//  ResultComponentVC.swift
//  MaqsadAssignment
//
//  Created by Bisma Soomro on 23/09/2022.
//

import UIKit
import Combine

class ResultComponentVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @Published var isAnimating = false
    var cancelables = Set<AnyCancellable>()
    var responseData: ResponseData?
    var items = [Items]()
    var limit = 9
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setObserver()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if responseData?.items?.count ?? 0 > 0 {
            var index = 0
            while index < limit {
                    if let response = responseData?.items{
                        items.append(response[index])
                        index += 1
                    }
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "There is no user with this search", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        items = items.sorted{ fir, sec in
            fir.login ?? "" < sec.login ?? ""
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cancelables.removeAll()
    }

    // MARK: - setObserver()
    func setObserver(){
        $isAnimating.receive(on: DispatchQueue.main).sink { value in
            if value {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }.store(in: &cancelables)
    }
}


// MARK: - extension: UITableViewDelegate, UITableViewDataSource
extension ResultComponentVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserViewCellId", for:  indexPath) as? UserViewCell{
            cell.responseItem = items[indexPath.item]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count - 1 {
            if let response = responseData?.items {
                if items.count < response.count{
                    isAnimating = true
                    var index =  items.count
                    limit = index + 9
                    if limit > response.count {
                        limit = limit - response.count
                        isAnimating = false
                    }
                    
                    while index < limit {
                        items.append(response[index])
                        index += 1
                    }
                    self.perform(#selector(loadMoreItems), with: nil, afterDelay: 1)
                    } else {
                    isAnimating = false
                }
            }
        }
    }
    
    @objc func loadMoreItems(){
        isAnimating = false
        tableView.reloadData()
    }
}

