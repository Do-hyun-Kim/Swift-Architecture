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
    
    private var placeholderTitleTextView: UITextView = {
        $0.text = """
        tip\n
        아래와 같은 조합으로 검색을 하시면 더욱 정확한 결과가 검색됩니다.\n
        도로명 + 건물 번호 \n
        예) 판교역로 235, 제주 첨단로 242\n
        지역명(동/리) + 번지\n
        예) 분당 주공, 연수동 주공 3차\n
        사서 함명 + 번호\n
        예) 분당 우체국사서함 1~100
        """
        $0.font = .systemFont(ofSize: 12)
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.isSelectable = false
        return $0
    }(UITextView())
    
    lazy var searchBar: AdressSearchBar = AdressSearchBar()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        let placeholderString = placeholderTitleTextView.text.components(separatedBy: "\n\n")
        
        print(placeholderString)
        placeholderTitleTextView.attributedText = placeholderTitleTextView.searchAttributed(from:  [placeholderString[3],placeholderString[5],placeholderString[7]], adress: [placeholderString[1],placeholderString[2],placeholderString[4],placeholderString[6]], color: .systemBlue, font: .boldSystemFont(ofSize: 12))
        
        
        [adressTitleLabel,searchBar, placeholderTitleTextView].forEach {
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
        
        placeholderTitleTextView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.left.equalTo(searchBar).offset(10)
            $0.right.equalTo(searchBar)
            $0.height.equalTo(400)
        }
    }

}
