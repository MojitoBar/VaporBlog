---
date: 2022년 07월 30일 22:35
description: SOLID 완전 정복하기
oneline: 객체지향 언어하면 꼭 나오는 SOLID(가수아님)에 대해
tags: Swift, CS
thumbnail: /images/swiftlogo.png
contents: SOLID 원칙/SRP - 단일 책임 원칙/OCP - 개방&폐쇄 원칙/LSP - 리스코프 치환 원칙/ISP - 인터페이스 분리 원칙/DIP - 의존관계 역전 원칙/느낀점
file: SOLID
---

## SOLID 원칙

컴퓨터 프로그래밍에서 SOLID란 로버트 마틴이 2000년대 초반에 명명한 객체 지향 프로그래밍 및 설계의 다섯가지 기본 원칙을 마이클 페더스가 두문자어 기억술로 소개한 것입니다. [출처](https://ko.wikipedia.org/wiki/SOLID_(%EA%B0%9D%EC%B2%B4_%EC%A7%80%ED%96%A5_%EC%84%A4%EA%B3%84)

SOLID 원칙들은 소프트웨어 작업에서 프로그래머가 소스 코드가 읽기 쉽고 확장하기 쉽게 될 때까지 소프트웨어 소스 코드를 리팩토링하여 [코드 스멜](https://ko.wikipedia.org/wiki/%EC%BD%94%EB%93%9C_%EC%8A%A4%EB%A9%9C)을 제거하기 위해 적용할 수 있는 지침입니다.

한 마디로 프로그래밍 전략이라 할 수 있죠.

~~SOLID~~는 **SRP, OCP, LSP, ISP, DIP** 로 이루어져있는데 지금부터 순서대로 하나씩 알아보겠습니다.

## SRP - 단일 책임 원칙

~~SRP 원칙~~은 모든 클래스는 하나의 책임만 가지며, 클래스는 그 책임을 완전히 [캡슐화](https://ko.wikipedia.org/wiki/%EC%BA%A1%EC%8A%90%ED%99%94)해야 함을 일컫습니다.

<pre class="language-swift line-numbers">
<code>class Capsule1 {
    number: Int
    public Capsule(number: Int) {
        self.number = number;
    }
    public func getHalf() -> Double {
        return number / 2
    }
}

class Capsule2 {
    number: Int
    public Capsule(number: Int) {
        self.number = number;
    }
    public func getNumber() -> Int {
        return number
    }
}

-------------------------------------------
// main
// 첫번째 예제
var capsule1 = Capsule1(10)
capsule1.getHalf()

// 두번째 예제
var capsule2 = Capsule2(10)
calsule2.getNumber() / 2</code>
</pre>

두 캡슐 클래스의 차이가 뭘까요? 캡슐화를 지키기 위한 규칙으로는 크게 2가지가 있습니다. 

하나는 ~~TDA~~, 다른 하나는 ~~Demeter 법칙~~ 인데요.

~~TDA~~는 **Tell, Don’t Ask**로 객체 내부의 데이터를 꺼내와서 처리하는게 아닌, 객체에게 처리할 행위를 요청하라는 뜻입니다.

그리고 이것을 우리는 **객체에 메세지를 보낸다** 라고 말합니다.

~~Demeter 법칙~~은 **다른 객체를 탐색해 뭔가를 일어나게 해서는 안 된다.** 라는 법칙인데요,

이렇게 될 경우 하나의 변화에 수많은 클래스들을 수정해야할 가능성이 있기 때문입니다. 그렇기 때문에 한줄에 .을 하나만 찍는다 라고 요약되기도 합니다.

즉, 캡슐화를 통해 우리가 얻을 수 있는 장점은 코드의 중복을 피할 수 있다는 점과, 변화에 유연하게 대처할 수 있다는 점이 있습니다.

이러한 규칙을 지키는 것이 ~~SRP 원칙~~입니다.

## OCP - 개방&폐쇄 원칙

개방-폐쇄 원칙은 소프트웨어 개체는 확장에 대해 열려 있어야 하고, 수정에 대해서는 닫혀 있어야 한다는 프로그래밍 원칙입니다.

<pre class="language-swift line-numbers">
<code>class File {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class FileStorage {
    func saveOracle(file: File) {
        print("save the \(file) to Oracle")
    }
    func saveMySQL(file: File) {
        print("save the \(file) to MySQL")
    }
}</code>
</pre>

위 예제에는 Oracle에 파일을 저장하는 함수와 MySQL에 파일을 저장하는 함수가 있습니다.

만약 MongoDB에 파일을 저장하는 기능을 추가해야한다면 FileStorage 클래스의 수정이 일어나게 되는데요, 그렇기 때문에 ~~OCP 원칙~~을 위반하는 코드라 할 수 있습니다.

이를 ~~OCP 원칙~~을 지키게끔 리팩토링 해보면 아래와 같습니다.

<pre class="language-swift line-numbers">
<code>class File {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class FileStorage {
    func saveFile(file: File) { }
}

class Oracle: FileStorage {
    override func saveFile(file: File) {
        print("save the \(file) to Oracle")
    }
}

class MySQL: FileStorage {
    override func saveFile(file: File) {
        print("save the \(file) to MySQL")
    }
}</code>
</pre>

이렇게 구현하는 경우엔 MongoDB에 파일을 추가하는 기능을 추가해야하는 경우에 어떠한 클래스의 수정도 일어나지 않고, FileStorage의 확장만 일어납니다.

이처럼 ~~OCP 원칙~~은 유연성, 재사용성, 유지보수성 등 수정이 쉬운 코드를 작성할 수 있게 된다는 장점이 있습니다.

## LSP - 리스코프 치환 원칙

프로그램에서 자료형 S가 자료형 T의 하위형이라면 필요한 프로그램의 속성의 변경 없이 자료형 T의 객체를 자료형 S의 객체로 교체할 수 있어야 한다는 원칙입니다.

말이 어렵지만 쉽게 설명하면 자식 객체가 부모 객체를 완전히 대체할 수 있어야한다는 뜻입니다. 아래 예제를 보면 이해가 쉽습니다.

<pre class="language-swift line-numbers">
<code>class Rectangle {
    var width: Int = 0
    var height: Int = 0
    
    func getWidth() -> Int {
        return width
    }
    
    func getHeight() -> Int {
        return height
    }
    
    func setWidth(width: Int) {
        self.width = width
    }
    
    func setHeight(height: Int) {
        self.height = height
    }
    
    func getArea() -> Int {
        return width * height
    }
}

class Square: Rectangle {
    override func setWidth(width: Int) {
        self.width = width
        self.height = width
    }
    
    override func setHeight(height: Int) {
        self.height = height
        self.width = height
    }
}</code>
</pre>

위 예제는 직사각형 클래스 **Rectangle**를 만들어 이를 정사각형 **Sqaure**에 적용한 코드입니다.

수학적으로 보면 정사각형은 직사각형에 속해있기 때문에 위와 같이 구현한 것인데요,

리스코프 치환 법칙에 따르면 ~~Squar~~가 ~~Rectangle~~을 완전히 대체할 수 있어야한다는 뜻입니다.

<pre class="language-swift line-numbers">
<code>var rectangle1: Rectangle = Rectangle()
rectangle1.setWidth(width: 10)
rectangle1.setHeight(height: 5)

print(rectangle1.getArea())

var rectangle2: Rectangle = Square()
rectangle2.setWidth(width: 10)
rectangle2.setHeight(height: 5)

print(rectangle2.getArea())</code>
</pre>

그러나 위 예제를 보면 결과 값이 다른 것을 확인할 수 있습니다. 즉 ~~LSP 법칙~~을 위반하고 있다는 뜻이죠.

이를 규칙에 준수하는 코드로 변경하면 아래와 같습니다.

<pre class="language-swift line-numbers">
<code>class Shape {
    var width: Int = 0
    var height: Int = 0
    
    func getWidth() -> Int {
        return width
    }
    
    func getHeight() -> Int {
        return height
    }
    
    func setWidth(width: Int) {
        self.width = width
    }
    
    func setHeight(height: Int) {
        self.height = height
    }
    
    func getArea() -> Int {
        return width * height
    }
}

class Square: Shape {
    init(length: Int) {
        super.init()
        setWidth(width: length)
        setHeight(height: length)
    }
}

class Rectangle: Shape {
    init(width: Int, height: Int) {
        super.init()
        setWidth(width: width)
        setHeight(height: height)
    }
}

var rectangle1: Shape = Rectangle(width: 10, height: 5)
print(rectangle1.getArea())

var rectangle2: Shape = Square(length: 5)
print(rectangle2.getArea())</code>
</pre>

최상위 Shape 클래스를 만들어 각각 상속을 받게 수정함으로 더이상 정사각형과 직사각형은 직접적인 관계가 없어지게 됩니다. 리스코프 치환 원칙의 영향에서 벗어난 것이죠.

위와 같이 올바르지 못한 상속관계를 제거하고, 자식이 부모 객체의 동작을 완벽하게 대체할 수 있게 하는 것이 ~~LSP 원칙~~입니다.

~~LSP 원칙~~을 준수하면 불필요한 결합이 없어지므로 기능을 확장할 때 수정 사항을 적게 가져갈 수 있다는 장점이 있습니다.

## ISP - 인터페이스 분리 원칙

인터페이스 분리 원칙은 클라이언트가 자신이 이용하지 않는 메서드에 의존하지 않아야 한다는 원칙입니다.

<pre class="language-swift line-numbers">
<code>class SmartPhone {
    func call(name: String) {
        print("\(name) 통화 연결")
    }
    func message(number: String, text: String) {
        print("\(number): \(text)")
    }
    func wirelessCharge() {
        print("무선 충전")
    }
    func ar() {
        print("AR 기능")
    }
    func biometrics() { }
}

class S20: SmartPhone {
    override func biometrics() {
        print("S20 생체인식 기능")
    }
}

class S2: SmartPhone {
    override func wirelessCharge() {
        print("지원 불가능한 기기")
    }
    
    override func ar() {
        print("지원 불가능한 기기")
    }
    
    override func biometrics() {
        print("지원 불가능한 기기")
    }
}</code>
</pre>

S20의 경우 모든 기능을 지원하기 때문에 불필요한 메소드가 없지만 S2의 경우 불필요한 메소드가 많은데요, 이러한 현상은 부모 객체의 규모가 크면 클수록 개발 편의성의 극심한 저하로 이어집니다.

아래는 ~~ISP 원칙~~을 지켜 리펙토링한 코드입니다.

<pre class="language-swift line-numbers">
<code>class SmartPhone {
    func call(name: String) {
        print("\(name) 통화 연결")
    }
    func message(number: String, text: String) {
        print("\(number): \(text)")
    }
}

protocol WirelessChargable {
    func wirelessCharge()
}

protocol ARalbe {
    func ar()
}

protocol Biometricsable {
    func biometrics()
}

class S20: SmartPhone, WirelessChargable, ARalbe, Biometricsable {
    func wirelessCharge() {
        print("무선 충전 가능")
    }
    
    func ar() {
        print("AR 가능")
    }
    
    func biometrics() {
        print("S20 생체인식 기능")
    }
}

class S2: SmartPhone { }</code>
</pre>

Swift에서는 protocol, Java에서는 Interface 등을 활용해 인터페이스를 분리한 코드입니다.

~~ISP 원칙~~을 지키면 불필요한 기능의 상속/구현을 최대한 방지함으로써 객체의 불필요한 책임을 제거하며 확장성을 향상시킬 수 있다는 장점이 있습니다.

## DIP - 의존관계 역전 원칙

의존관계 역전 원칙은 소프트웨어 모듈들을 분리하는 특정 형식을 지칭하는데요,

추상화된 것은 구체적인 것에 의존하면 안되고 구체적인 것이 추상화된 것에 의존해야한다는 원칙입니다.

<pre class="language-swift line-numbers">
<code>class Person: Americano { }

class Americano {
    func drink() {
        print("아메리카노를 마신다.")
    }
}

class Latte {
    func drink() {
        print("라떼를 마신다.")
    }
}

var person = Person()
person.drink()</code>
</pre>

위 예제는 특정 커피클래스에 의존하기 때문에 라떼를 마시는 기능을 추가해야하는 경우 수정이 용이하지 않습니다. 즉, ~~DIP 원칙~~을 지키지 않은 코드이죠.

<pre class="language-swift line-numbers">
<code>class Person {
    let coffee: Coffee
    
    init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    func drink() {
        coffee.drink()
    }
}

protocol Coffee {
    func drink()
}

class Americano: Coffee {
    func drink() {
        print("아메리카노를 마신다.")
    }
}

class Latte: Coffee {
    func drink() {
        print("라떼를 마신다.")
    }
}

var person = Person(coffee: Latte())
person.drink()</code>
</pre>

위 코드는 ~~DIP 원칙~~을 준수한 코드인데요, 이렇게 되면 Person이 특정 커피에 의존하지 않을 수 있습니다. 

만약 새로운 커피 종류가 추가되어도 Person 객체는 수정이 일어나지 않는습니다. 

또한 **구체적인 것(커피종류)가 추상화 된것(커피 클래스)에 의존**하고 있기 때문에 상위 계층이 하위 계층 구현으로부터 독립되게 할 수 있습니다.

## 느낀점

한번에 모든 원칙을 한번에 준수하며 코드를 작성하는 것은 불가능에 가깝다고 생각합니다.

Swift에서 SOLID는 선택이라 생각합니다. 또한 Swift는 Apple에서 멀티 페러다임이라고 소개한 적도 있습니다.

하지만 SOLID 원칙을 준수한다면 객체지향의 장점을 극대화시킬 수 있기 때문에 적절한 위치에서 적용할 시 매우 유용할 것 같다고 생각하게 되었습니다.

앞으로 리펙토링을 한다면 SOLID 원칙에 위배되는 사항이 없는지, 있다면 꼭 그래야만 하는지 생각하는 습관을 들이려합니다.

## 참고자료
<ul>
<li>
    <a href="https://martinfowler.com/bliki/TellDontAsk.html">TDA 법칙</a>
</li>
<li>
    <a href="https://tecoble.techcourse.co.kr/post/2020-06-02-law-of-demeter/">디미터 법칙</a>
</li>
<li>
    <a href="https://yoongrammer.tistory.com/97#OCP_%EC%A0%81%EC%9A%A9_%EC%A0%84">OCP 원칙</a>
</li>
<li>
    <a href="https://blog.itcode.dev/posts/2021/08/15/liskov-subsitution-principle">LSP 원칙</a>
</li>
<li>
    <a href="https://blog.itcode.dev/posts/2021/08/16/interface-segregation-principle">ISP 원칙</a>
</li>
<li>
    <a href="https://old-developer.tistory.com/96">DIP 원칙</a>
</li>
</ul>
