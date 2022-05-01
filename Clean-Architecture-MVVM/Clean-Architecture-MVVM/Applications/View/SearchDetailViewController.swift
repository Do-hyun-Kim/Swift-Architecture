//
//  SearchDetailViewController.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/05/01.
//

import UIKit


class SearchDetailViewController: UIViewController {
    
    
    public var searchDetailViewModel: SearchDetailViewModel?
    
    init(searchDetailViewModel: SearchDetailViewModel) {
        self.searchDetailViewModel = searchDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data set detail \(searchDetailViewModel?.detailEntities)")
    }
    
}
