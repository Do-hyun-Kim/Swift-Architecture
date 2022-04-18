# Swift-Architecture

<H2>Solid 원칙</H2>

  - Solid 원칙은 더 좋은 아키텍쳐를 설계하기 위해 지켜야하는 원칙들의 5가지를 앞의 약어만 따서 정리한 단어이다.
  - 새롭게 어떤 기능이 추가되거나 유지 보수가 되어야 할때 더욱 생산성 있고 유연하게 대처가 가능해야한다고 생각 하기 떄문이다. 이를 위해 코드를 어떻게 설계하고 개발해 나아가는지 중요하기 위해 Solid 원칙을 사용한다.

<h2>SRP(Single Responsibility Principle) 단일 책임 원리</h2>

  - 클래스의 수정 이유는 단 하나여야 한다.
  - 하나의 클래스는 하나의 책임(Knowing, Doing)만 가져야 한다.
  - 하나의 책임이 여러개의 클래스에 나뉘어 있어서도 안된다.
  - 하나의 클래스 안에 협력관계(Collaboration)가 여러개가 있는것은 괜찮다.
  - 예) 클래스, 함수를 설계 할 때, 각 단위 들은 단 하나의 책임만을 가져야 한다는 원칙이다. 즉 클래스나, 함수가 새롭게 변해야 한다면 하나의 역할을 가진 상태에서 새로운 것으로 변해야 한다. -> 변하기는 하지만 역활은 변화면 안 된다는 의미<br><br>


  - Before : 하나의 클래스가 여러개의 책임(private으로 접근제한 된 다양한 메소드들)을 가지고 있다.
```swift
class Hanlder {
    
    func handler() {
        let data = requestDataToAPI()
        let array = parse(data: data)
        saveToDB(array: array)
    }
    
    private func requestDataToAPI() -> Data {
        // send API request and wait the response
        return Data()
    }
    
    private func parse(data: Data) -> [String] {
        // parse the data and create the array
        return [String]()
    }
    
    private func saveToDB(array: [String]) {
        // save the array in a database (CoreData/Realm/...)
    }
    
    
}
```
<br>
  - After : 하나의 클래스가 하나의 책임을 가지고 있다. Handler 클래스의 경우는 협력 관계(Collaboration)인 여러 클래스를 활용하여 하나의 책임을 가지고 있다.

```swift
protocol APIHandlerProtocol {
    func reqeustDataToAPI() -> Data
}

protocol DecodingHandlerProtocol {
    func parse(data: Data) -> [String]
}

protocol DBHandlerProtocol {
    func saveToDB(array: [String])
}


class APIHandler {
    
    let apiHandler: APIHandlerProtocol
    let decodingHandler: DecodingHandlerProtocol
    let dbHandler: DBHandlerProtocol
    
    init(apiHandler: APIHandlerProtocol, decodingHandler: DecodingHandlerProtocol, dbHandler: DBHandlerProtocol) {
        self.apiHandler = apiHandler
        self.decodingHandler = decodingHandler
        self.dbHandler = dbHandler
    }
    
    func handler() {
        let apiHandler = apiHandler.reqeustDataToAPI()
        let decoding = decodingHandler.parse(data: Data())
        let dbhandler = dbHandler.saveToDB(array: [String]())
    }
    
}
```
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

