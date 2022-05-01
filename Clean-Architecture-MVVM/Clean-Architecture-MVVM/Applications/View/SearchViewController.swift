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
    
    private let actionButton: UIButton = {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.titleLabel?.textAlignment = .center
        $0.addTarget(self, action: #selector(bindAction), for: .touchUpInside)
        $0.backgroundColor = .systemTeal
        return $0
    }(UIButton())
    
    lazy var adressSearchBar: AdressSearchBar = AdressSearchBar()
    private var searchViewModel: SearchViewModel?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        let placeholderString = placeholderTitleTextView.text.components(separatedBy: "\n\n")
        
        placeholderTitleTextView.attributedText = placeholderTitleTextView.searchAttributed(from:  [placeholderString[3],placeholderString[5],placeholderString[7]], adress: [placeholderString[1],placeholderString[2],placeholderString[4],placeholderString[6]], color: .systemBlue, font: .boldSystemFont(ofSize: 12))
        
        
        [adressTitleLabel,adressSearchBar, placeholderTitleTextView,actionButton].forEach {
            view.addSubview($0)
        }
        
        adressTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.height.equalTo(40)
        }
        
        adressSearchBar.snp.makeConstraints {
            $0.top.equalTo(adressTitleLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.height.equalTo(80)
        }
        
        placeholderTitleTextView.snp.makeConstraints {
            $0.top.equalTo(adressSearchBar.snp.bottom).offset(20)
            $0.left.equalTo(adressSearchBar).offset(10)
            $0.right.equalTo(adressSearchBar)
            $0.height.equalTo(400)
        }
        
        actionButton.snp.makeConstraints {
            $0.top.equalTo(adressSearchBar)
            $0.left.equalTo(adressSearchBar.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(adressSearchBar)
            $0.width.equalTo(50)
        }
    }

    
    //MARK: Action
    
    @objc
    private func bindAction() {
        let requestValue: RequestValue = RequestValue(confmKey: "devU01TX0FVVEgyMDIyMDQyODE4NDMwMTExMjUxNTA=", keyword: adressSearchBar.searchBar.text!, countPerPage: "10", currentPage: "1", resultType: "json")
        let searchLayer: SearchAPILayer = SearchAPILayer(requestValue: requestValue)
        searchViewModel = SearchViewModel(searchLayer: searchLayer)
        
        searchViewModel?.fetchSearchAdress {
            let detailVC = SearchDetailViewController(searchDetailViewModel: SearchDetailViewModel())
            detailVC.searchDetailViewModel?.detailEntities = self.searchViewModel!.entities
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    
    }
}
