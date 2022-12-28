//
//  ViewController.swift
//  Swift-ReSwift
//
//  Created by Kim dohyun on 2022/12/28.
//

import UIKit
import SnapKit
import ReSwift

protocol ViewComposinable {
    func configure()
}



class ViewController: UIViewController {

    //MARK: Property
    
    typealias StoreSubscriberStateType = AppState
    
    private let counterLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.text = "0"
        $0.textColor = .black
        return $0
    }(UILabel())
    
    
    private lazy var incrementButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(self.didTapIncrementButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(self.didTapDecrementButton(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStore.subscribe(self)
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.subscribe(self)
    }

    
    //MARK: Action
    @objc
    private func didTapIncrementButton(_ sender: AnyObject) {
        mainStore.dispatch(Swift_ReSwift.didTapIncrementButton())
    }
    
    @objc
    private func didTapDecrementButton(_ sender: AnyObject) {
        mainStore.dispatch(Swift_ReSwift.didTapDecrementButton())
    }

}

//MARK: Extension
extension ViewController: ViewComposinable, StoreSubscriber{
    
    func configure() {
        _ = [counterLabel, incrementButton, decrementButton].map {
            self.view.addSubview($0)
        }
        
        counterLabel.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(24)
            $0.center.equalToSuperview()
        }
        
        decrementButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.left.equalTo(counterLabel.snp.right).offset(10)
            $0.centerY.equalTo(counterLabel)
        }
        
        incrementButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.right.equalTo(counterLabel.snp.left).offset(-10)
            $0.centerY.equalTo(counterLabel)
        }
        
        
    }
    
    
    func newState(state: AppState) {
        counterLabel.text = "\(state.globalCount)"
    }
    
}

