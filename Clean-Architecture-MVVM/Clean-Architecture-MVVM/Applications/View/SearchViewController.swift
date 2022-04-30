//
//  SearchViewController.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/20.
//

import UIKit
import SnapKit



class SearchViewController: UIViewController {
    
    //MARK: Property
    private var adressTitleLabel: UILabel = {
        $0.text = "우편번호 찾기"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: 22)
        
        return $0
    }(UILabel())
    
    private var placeholderTitleLabel: UILabel = {
        
        
        return $0
    }(UILabel())
    
    lazy var searchBar: AdressSearchBar = AdressSearchBar()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        [adressTitleLabel,searchBar].forEach {
            view.addSubview($0)
        }
        
        adressTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.height.equalTo(40)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(adressTitleLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(80)
        }
    }

}




final class AdressSearchBar: UIView, UISearchBarDelegate {
    
    //MARK: Property
    public var searchBar: UISearchBar = {
        $0.placeholder = "예) 판교역로 235 한남동 714"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.1
        
        return $0
    }(UISearchBar())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure() {
        searchBar.delegate = self
        if let textFiled = searchBar.value(forKey: "searchField") as? UITextField {
            textFiled.attributedPlaceholder = NSAttributedString(string: textFiled.placeholder ?? "", attributes: [.font : UIFont.boldSystemFont(ofSize: 13)])
            textFiled.textColor = .black
            textFiled.backgroundColor = .white
        }
        addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
    
    
}
