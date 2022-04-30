//
//  AdressSearchBar.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/30.
//

import UIKit


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
