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

<h2>OCP(Open-Closed Principle) 개방, 폐쇠 원칙</h2>

  - 어떤 기능을 추가할때 기존의 코드는 만지지 않고 새로 동작하는 기능에 대해서만 코드가 작성 되어야 한다.
  - 확장에는 열려 있으나 변경에는 닫혀 있어야 한다.(기능 케이스를 추가할 때 기존 코드를 변경하지 않고 확장해야 한다.)
  - 객체가 변경될 때는 해당 객체만 바꿔도 동작이 잘되면 OCP를 잘지킨 것이고, 바꿔야 할 것이 많으면 OCP를 잘 안 지킨 것 이다.
  - 모듈이 주변 환경에 지나치게 의존 하면 안된다.<br><br>


  - Before : Country 열거형에 case를 추가하면 printNameOfCountry 함수도 수정해야 한다. 결합도와 의존성이 높고, 유지보수가 힘들다.

```swift
enum Country {
    case korea
    case china
    case japan
}


class Flag {
    let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
}

func printNameOfCountry(flag: Flag) {
    switch flag.country {
    case .china:
        print("중국")
    case .korea:
        print("한국")
    case .japan:
        print("일본")
    }
}

enum HyunCountry {
    case korea
    case china
    case japan
    case usa
    
    
    var name: String {
        switch self {
        case .korea:
            return "한국"
        case .china:
            return "중국"
        case .japan:
            return "일본"
        case .usa:
            return "미국"
        }
    }
}


class HyunFlag {
    let country: HyunCountry
    
    init(country: HyunCountry) {
        self.country = country
    }
}

func printNameOfHyunCountry(country: HyunCountry) {
    print(country.name)
}


//MARK: Before
//MARK: 새로운 동물 Class를 생성 해줄때마다 Zoo에 코드를 추가해주어야 하기 때문에 폐쇠 적이지 못하다.
class Dog {
    func makeSound() {
        print("멍멍")
    }
}

class Cat {
    func makeSound() {
        print("야옹")
    }
}


class Zoo {
    var dogs: [Dog] = [Dog(),Dog(),Dog()]
    var cats: [Cat] = [Cat(),Cat(),Cat()]
    
    func makeAllSounds() {
        dogs.forEach {
            $0.makeSound()
        }
        cats.forEach {
            $0.makeSound()
        }
    }
}


var hyunZoo: Zoo = Zoo()
hyunZoo.makeAllSounds()

```
<br>

  - After : 도시를 추가하고 싶다면 Countrable을 채택하는 구조체를 생성 하기만 하면 된다. 결합도가 낮고 응집도가 높아 유지보수가 용이하다. -> 버그가 일어 나지 않는다.

```swift
protocol Countrable {
    var name: String { get }
}

struct Korea: Countrable {
    let name: String = "한국"
}

struct Japan: Countrable {
    let name: String = "일본"
}

struct China: Countrable {
    let name: String = "중국"
}

class SolidCountry {
    let country: Countrable
    
    init(country: Countrable) {
        self.country = country
    }
}

func printNameOfCountrable(country: Countrable) {
    print(country.name)
}

//MARK: After

protocol Animal {
    func makeSound()
}

class Pig: Animal {
    func makeSound() {
        print("꿀꿀")
    }
}

class Bird: Animal {
    func makeSound() {
        print("짹짹")
    }
}


class HyunZoo {
    var animals: [Animal] = []
    
    func makeAllSounds() {
        animals.forEach {
            $0.makeSound()
        }
    }
}


```

<h2>LSP(Liskov Substitution Principle) 리스코프 치환 원칙</h2>

  - 서브타입(자식 클래스)은 상속 받은(기본 타입)으로 대체 가능 해야한다
  - 자식 클래스는 부모 클래스의 동작(의미)를 바꾸지 않는다.
  - 상속을 사용했을 때 서브클래스는 자신의 슈퍼 클래스 대신 사용되도 같은 동작을 해야한다.

<br>

  - Before


```swift
class Rectangle {
    var width: Float = 0
    var height: Float = 0
    
    var area: Float {
        return width * height
    }
}


class Square: Rectangle {
    override var width: Float {
        didSet {
            height = width
        }
    }
}



func printArea(of rectangle: Rectangle) {
    rectangle.height = 5
    rectangle.width = 2
    print(rectangle.area)
}


let hyunRectAngle = Rectangle()
printArea(of: hyunRectAngle)


let Hyunsquare = Square()
printArea(of: Hyunsquare)
```
<br>

  - After


```swift
protocol Shape {
    var area: CGFloat { get }
}

class HyunRectAngle: Shape {
    private let width: CGFloat
    private let height: CGFloat
    
    var area: CGFloat {
        return width * height
    }
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    
}

class HyunSquare: Shape {
    private let length: CGFloat
    
    var area: CGFloat {
        return length * length
    }
    
    init(length: CGFloat) {
        self.length = length
    }
}
```

<h2>ISP(Interface Segregation Principle) 인터페이스 분리 원칙</h2>

  - 클래스 내에 사용하지 않는 인터페이스는 구현하지 말아야 한다.
  - 클라이언트 객체는 사용하지 않는 메소드에 의존하지 말아야 한다.
  - 인터페이스가 거대해지는 경우 SRP(단일 책임 원칙)을 어기는 경우가 생길 수 있고, 해당 인터페이스를 채택해서 사용하는 경우 쓰지 않는 메소드가 있어도 넣어야 하는 경우가 발생할 수 있으니 최대한 인터페이스를 분리하는 것을 권장

  - Before
```swift
protocol GeneralProtocol {
    func didTap()
    func didLongTap()
    func didMultiTap()
}

class GestureButton: GeneralProtocol {
    
    func didTap() {}
    
    func didLongTap() {}
    
    func didMultiTap() {}
}

//MARK: DoubleButton Class에 didTap, didLongTap의 사용하지 않는 메소드 까지 구현되어 있다.
class DoubleButton: GeneralProtocol {
    
    func didMultiTap() {
        
    }
    
    //MARK: Useless
    func didTap() {
        <#code#>
    }
    
    func didLongTap() {
        <#code#>
    }
}
```
<br>

  - After : 프로토콜을 분리함으로써 필요한 프로토콜만 채택하게되어 사용하지 않는 메소드가 없어졌다.
```swift
protocol TapGestureProtocol {
    func didTap()
}

protocol LongTapGestureProtocol {
    func didLongTap()
}

protocol MultiTapGestureProtocol {
    func didMultiTap()
}


class HyunGestureButton: TapGestureProtocol, LongTapGestureProtocol, MultiTapGestureProtocol {
    func didTap() {}
    func didLongTap() {}
    func didMultiTap() {}
}

class MultiTapGestureButton: MultiTapGestureProtocol {
    func didMultiTap() {}
}

class LongTapGestureButton: LongTapGestureProtocol, TapGestureProtocol {
    func didTap() {}
    func didLongTap() {}
}

func doSomeThing(button: LongTapGestureProtocol & TapGestureProtocol) {
    button.didTap()
    button.didLongTap()
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

