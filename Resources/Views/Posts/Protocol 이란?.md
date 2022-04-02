---
date: 2022년 04월 02일 19:15
description: Protocol 이란?
oneline: "아키텍처를 공부하다 만난 protocol 코드를 이해하기 위한 과정"
tags: iOS, Swift
thumbnail: /images/swiftlogo.png
contents: Protocol/기본적인 사용법/Protocol VS Class/Protocol의 장점을 살린 예제/Protocol Type?/정리
---

## Protocol
이번 포스팅에서는 Swift의 ~~Protocol~~에 대해서 정리해보려 합니다.

먼저 여기서 다루는 내용은 **VIPER 아키텍처**를 공부하다 생긴 protocol에 대한 궁금증을 해결하는데 집중되어 있음을 알립니다.

따라서 이론적인 부분이나 개념은 깊게 다루지 않을 수도 있습니다. 

[Swift Docs](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)에서는 **procotol**을 아래와 같이 정의합니다.

<img alt="protocol" src="/images/protocol.png"/>

> 프로토콜은 특정 작업이나 기능에 적합한 메서드, 속성 및 기타 요구 사항의 청사진을 정의합니다. 그런 다음 프로토콜은 해당 요구 사항의 실제 구현을 제공하기 위해 클래스, 구조 또는 열거에 의해 채택될 수 있습니다. 프로토콜의 요구 사항을 충족하는 모든 유형은 해당 프로토콜을 준수한다고 합니다.

글만 봐서는 잘 와닿지 않는 것 같은데 중요한 점은 ~~청사진~~이라는 점입니다.

그럼 바로 예제 코드로 넘어가겠습니다.

## 기본적인 사용법
프로토콜을 설명하는데 유명한 예시인 탈것을 통해 알아보겠습니다.

<pre class="language-swift line-numbers">
<code>class Car {
    var name: String
    var maxFuel: Int
    
    init(name: String, maxFuel: Int) {
        self.name = name
        self.maxFuel = maxFuel
    }
    
    func start() {
        print("자동차 시동걸기..")
    }
    
    func forward() {
        print("앞으로 가기..")
    }
}

class Airplane {
    var name: String
    var maxFuel: Int
    
    init(name: String, maxFuel: Int) {
        self.name = name
        self.maxFuel = maxFuel
    }
    
    func start() {
        print("비행기 시동걸기..")
    }
    
    func fly() {
        print("날아가기..")
    }
}</code>
</pre>

여기 자동차와 비행기 클래스가 있습니다.

각 객체는 탈것의 이름과, 연료 용량 변수와 시동을 거는함수, 움직임을 나타내는 함수로 이루어져있습니다.

자동차와 비행기라는 종류는 다르지만 딱 봐도 탈것이라는 상위 카테고리로 묶을 수 있을 것 같이 생겼는데요, **name**, **maxFuel**, **start()**가 중복되는 것을 알 수 있습니다. 

이럴 때 바로 프로토콜 사용하여 중복된 코드를 묶을 수 있습니다.

<pre class="language-swift line-numbers">
<code>protocol Vehicle {
    var name: String { get set }
    var maxFuel: Int { get set }
    
    func start()
}

class Car: Vehicle {
    // 생략...
}

class Airplane: Vehicle {
    // 생략...
}</code>
</pre>

Vehicle이라는 프로토콜을 만들고 그 안에 중복된 내용을 작성한 뒤 각 클래스에 프로토콜 상속을 해줬습니다.

위와 같이 사용하게 되면 새로운 보트나 기차와 같은 탈것이 생겨도 Vehicle만 상속 받으면 쉽고 빠르게 필요한 기능을 구현할 수 있을 것 같습니다.

그런데 여기서 이런 궁금한 점이 생길 수 있습니다.

**"Vehicle이라는 프로토콜이 Class여도 똑같지 않나? 왜 프로토콜이어야 하지?"**

위 예제만 보면 그렇게 생각할 수 있습니다. 그럼 ~~Class상속~~과 ~~Protocol상속~~이 어떻게 다른지 알아보겠습니다.

## Protocol VS Class
먼저 가장 큰 차이점은 ~~단일 상속~~과 ~~다중 상속~~입니다.

Swift에서는 Class의 다중 상속을 지원하지 않습니다. 하지만 Protocol은 몇개든 상속이 가능합니다.

때문에 Class의 상속은 상속받는 객체가 **하위 카테고리**인 경우에 유용하게 사용할 수 있고, Protocol의 경우 카테고리보단 **"하는 역할"**에 초점을 맞추는게 유용하게 사용할 수 있습니다.

그래서 [Swift API design guidelines](https://www.swift.org/documentation/api-design-guidelines/)에서도 어떤 것을 설명하는 **명사** 이거나 기능을 설명하는 **형용사**를 사용하는 것을 추천합니다. 

자세한 내용을 2번째 예제에서 알아보도록 하겠습니다.

두 번째 차이점으로 Class는 Class에서만 상속가능한데 반해 Protocol은 Class, Struct, Enum에서 모두 상속이 가능합니다.

위와 같은 이유로 Class 상속만을 사용할 때 보다 더욱 간결하고 강력하게 클린한 코드를 작성할 수 있다고 하네요. [POP](https://developer.apple.com/videos/play/wwdc2015/408/)가 나오게 된 이유인 것 같기도 합니다.

## Protocol의 장점을 살린 예제
그럼 위에서 알아본 차이점을 바탕으로 장점을 좀 더 살린 예제를 알아보겠습니다.

<pre class="language-swift line-numbers">
<code>protocol Runable {
    var velocity: Int { get set }
}

protocol Talkable {
    var text: String { get set }
}

protocol Flyable {
    var flightTime: Int { get set }
}

protocol Swimable {
    var diveTime: Int { get set }
}

class Person: Runable, Talkable, Swimable {
    var velocity: Int = 7
    
    var text: String = "말할 수 있지롱"
    
    var diveTime: Int = 60
}

class Frog: Runable, Swimable {
    var velocity: Int = 3
    
    var diveTime: Int = 600
}

class Bird: Flyable {
    var flightTime: Int = 1000
}</code>
</pre>

코드를 보면 **Runable**, **Talkable**, **Flyable**, **Swimable** 프로토콜을 구현하고 사람, 개구리, 새 클래스를 만들어 각각 해당되는 프로토콜을 상속 받았습니다.

위 예제를 보면 확실히 Class 상속과는 느낌이 다른 것을 알 수 있습니다.

Class 상속이 ~~수직으로 기능을 추가~~하는 것이라면 Protocol 상속은 ~~수평으로 기능을 추가~~하는 느낌을 받을 수 있습니다.

## Protocol Type?
이 부분은 제가 VIPER를 공부하다 생긴 의문입니다.

<pre class="language-swift line-numbers">
<code>class Bird: Flyable {
    var flightTime: Int = 1000
    
    func feed() {
        print("모이 주기~")
    }
}

var hawk: Flyable = Bird()

hawk.flightTime</code>
</pre>

위 코드는 **Bird()**라는 클래스를 생성하는데 ~~Type을 Flyable~~으로 한 경우 입니다.

그냥 클래스 타입으로 생성하는 것과는 어떤 차이가 있는지 궁금해 Playground로 여러가지 실험을 해본 결과, 프로토콜 타입의 경우엔 **프로토콜의 약속**만 따릅니다.

이게 무슨 말이냐면,

만약 위와 같은 코드에서 **hawk**의 **feed()**를 호출하려하면 에러가 발생합니다. **hawk**는 프로토콜 변수이기 때문에 **feed()** 함수는 없기 때문이죠.

추가적으로 프로토콜에서 지정한 get, set 규칙도 준수해야합니다.

그럼 저렇게 프로토콜 타입으로 생성된 hawk는 **RC를 증가** 시킬까요?

Bird 클래스에 init()을 추가해 실행해보면 RC를 증가시키는 것을 확인할 수 있습니다. 타입에 상관없이 Bird()를 생성 하는 것 자체가 RC를 증가시키기 때문이죠.

그럼에도 프로토콜 타입을 사용하는 이유는 해당 변수에 ~~규칙을 걸어주기 떄문~~이라 생각합니다.

프로토콜 타입으로 선언된 변수는 프로토콜이 가지고 있는 프로퍼티만 사용가능하게 되니 클래스에 있는 다른 프로퍼티에 접근하게 될 **위험**이 없어지기 떄문입니다.

## 정리
~~Protocol~~은 **기능의 수평확장을 하기 유리한 청사진**이라 생각하면 좋을 것 같습니다. 하나의 아키텍처를 공부하는데 있어서 엄청나게 튼튼하고 깊은 기본지식이 필요하다는 것을 느꼈습니다. 이어서 **VIPER**도 직접 적용해보고 포스팅 하려는 입장에서 정확하게 알아야하는 부분이 한 두가지가 아니네요..

이번 포스팅에선 ~~Protocol Extension~~이나 ~~Protocol Delegation~~의 내용은 다루지 않았습니다.

궁금했던 점과 기존의 지식을 정리하는 의미였기 때문이었는데, 기회가 된다면 다음번 포스팅에서 다루는 것으로 하겠습니다.

혹시나 오류나 문제가 있다면 댓글로 지적부탁드립니다.

## 참고자료
<ul>
<li>
    <a href="https://developer.apple.com/videos/play/wwdc2015/408/">Apple Developer</a>
</li>
<li>
    <a href="https://academy.realm.io/kr/posts/protocol-oriented-programming-in-swift/">Swift에서 프로토콜 중심 프로그래밍(POP)하기</a>
</li>
<li>
    <a href="https://zeddios.tistory.com/255">zeddios's tistory</a>
</li>
</ul>
