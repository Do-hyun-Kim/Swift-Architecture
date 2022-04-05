# Swift-Architecture


- <H3>MVP</H3>

```swift
//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


//MARK: Model - 해당 데이터를
struct Person {
    var name: String
    var age: Int
}

//MARK: View - (View,ViewController)가 여기에 해당, 비즈니스 로직에 해당하는 것은 Presenter에게 전달
protocol PersonView: AnyObject {
    func setView(color: UIColor, description: String)
}

//MARK: Presenter - View와 Model을 정의하며, View에 입력이 들어오면 그에 맞는 처리를 하며, 이에 필요한 Model을 사용한다. 또한 Output으로 View에게 전달
protocol PersonPresenter {
    init(view: PersonView, person: Person)
    func showView()
}

class Presenter: PersonPresenter {
    weak var view: PersonView?
    var person: Person
    
    
    required init(view: PersonView, person: Person) {
        self.view = view
        self.person = person
    }
    
    func showView() {
        if person.name == "Hyun" {
            view?.setView(color: .green, description: "Hello \(person.name)")
        } else {
            view?.setView(color: .brown, description: "Heelo Anonymous")
        }
    }
    
}




class MyViewController : UIViewController, PersonView {
    
    //MARK: Property
    private var backgroundView: UIView = {
        $0.backgroundColor = .white

        return $0
    }(UIView())
    
    private var contentLabel: UILabel = {
        $0.text = "Hello MVP"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        
        return $0
    }(UILabel())
    
    private var actionButton: UIButton = {
        $0.setTitle("action Button", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.frame = CGRect(x: 150, y: 250, width: 80, height: 40)
        $0.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    var presenter: Presenter!
    
    
    //MARK: LifeCycle
    override func loadView() {
        setUI()
    }
    
    //MARK: Configure
    private func setUI(){
        let model = Person(name: "yun", age: 24)
        let presenter2 = Presenter(view: self, person: model)
        presenter = presenter2
        presenter.view = self
        self.view = backgroundView
        backgroundView.addSubview(contentLabel)
        backgroundView.addSubview(actionButton)
    }
    
    //MARK: Action
    @objc
    private func didTapAction() {
        presenter.showView()
    }
    
    
    internal func setView(color: UIColor, description: String) {
        self.backgroundView.backgroundColor = color
        self.contentLabel.text = description
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

```

- <H5>MVP Custom</H5>
```swift
//
//  ViewController.swift
//  MVP
//
//  Created by Kim dohyun on 2022/04/05.
//

import UIKit


//MARK: Model
struct Model {
    var data: String
    var value: String
}


protocol PresenterView: AnyObject {
    func setLabelUI(_ label: String)
    func setButtonUI(_ text: String)
}

protocol ViewPresentable {
    init(view: PresenterView, model: Model)
    func setLabelUI()
    func setButtonUI()
}

class Presenter: ViewPresentable {
    weak var view: PresenterView?
    var model: Model
    
    required init(view: PresenterView, model: Model) {
        self.view = view
        self.model = model
    }
    
    func setLabelUI() {
        view?.setLabelUI(model.data)
    }
    
    func setButtonUI() {
        view?.setButtonUI(model.value)
    }
    
}





class ViewController: UIViewController, PresenterView {

    //MARK: Property
    var backgroundView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    var label: UILabel = {
        $0.text = "MVP"
        $0.frame = CGRect(x: 200, y: 150, width: 400, height: 20)
        $0.textColor = .black
        return $0
        
    }(UILabel())
    
    var button: UIButton = {
        $0.setTitle("set Label UI", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.frame = CGRect(x: 100, y: 250, width: 100, height: 30)
        $0.addTarget(self, action: #selector(didTapSetLabelAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    var button2: UIButton = {
        $0.setTitle("set Button UI", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.frame = CGRect(x: 100, y: 300, width: 150, height: 30)
        $0.addTarget(self, action: #selector(didTapSetButtonAction), for: .touchUpInside)
        
        return $0
    }(UIButton())
    
    
    var presenter: Presenter?
    var model: Model = Model(data: "Label Data", value: "Button Data")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUI()
    }
    
    
    private func getUI() {
        view.addSubview(backgroundView)
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(button2)
        presenter = Presenter(view: self, model: model)
        backgroundView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    
    func setButtonUI(_ text: String) {
        self.button.setTitle(text, for: .normal)
    }
    
    func setLabelUI(_ label: String) {
        self.label.text = label
    }
    

    
    @objc func didTapSetLabelAction() {
        presenter?.setLabelUI()
    }
    
    @objc func didTapSetButtonAction() {
        presenter?.setButtonUI()
    }


}
```

