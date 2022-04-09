---
date: 2022년 04월 09일 21:52
description: Protocol Delegate
oneline: 10번 봐도 모를 땐 11번, Delegate Pattern 정복하기
tags: iOS, Swift
thumbnail: /images/swiftlogo.png
contents: 이전 이야기/Delegate Pattern/AnyObject란?/왜 Weak?/왜 AnyObject?/Protocol Type/마무리 정리
file: ProtocolDeep
---

## 이전 이야기
저번 [포스팅](https://juseok.xyz/posts/Protocol)에서 ~~Protocol~~에 대한 개인적인 의문점을 해소하며 전반적인 사용법에 대해 알아 봤습니다. 

이번 포스팅에서는 지난번에 다루지 못했던 ~~Delegate 패턴~~에 대해 알아보도록 하겠습니다.

Protocol에 대한 배경지식이 부족하다면 이전 [포스팅](https://juseok.xyz/posts/Protocol)을 참조하는 것이 도움이 될 수 있습니다.

## Delegate Pattern
화면 전환에 대해 구글링하다 보면 한번쯤은 봤을법한 패턴입니다.

델리게이트 패턴에 대해선 **10번**은 족히 본 것 같지만 상세히 정리를 해보는 것은 이번이 처음인데요.

정말 간단하게 ~~Delegate = 위임자~~ 라고 생각하면 될 거 같아요. 거의 모든 블로그에서 **Delegate**를 **위임자**라고 설명하는데 확실히 이해하기 전까진 이게 도대체 무슨 의미일까 싶었습니다.

사실 우리는 ~~Delegate~~를 심심찮게 써봤을텐데요, 바로 **TextField**나 **ScrollView**를 사용할 때 입니다.

<pre class="language-swift line-numbers">
<code>tableView.delegate = self</code>
</pre>

바로 이 코드인데요, 이 것도 역시 **tableVie**의 변화를 **self**에서 관리하겠다~ 이런 뜻이라고 보면 될 것 같습니다.

그럼 바로 예제를 보며 도대체 뭘 위임하는 것인지 자세히 알아보겠습니다.

<pre class="line-numbers language-swift" data-line="1, 18">
<code>protocol changing: AnyObject {
    func getData(plus n: Int)
}

class firstVC: changing {
    func getData(plus n: Int) {
        num = 10 + n
    }

    var num = 10

    func onClick(b: secondVC) {
        b.delegate = self
    }
}

class secondVC {
    weak var delegate: changing?

    func sendData() {
        delegate?.getData(plus: 10)
    }
}

let first = firstVC()
let second = secondVC()
first.onClick(b: second)
second.sendData()
print(first.num)</code>
</pre>

먼저 ~~Delegate Pattern~~은 기본적으로 **A화면 -> B화면 -> A화면**로 전환되는 경우 B에서 A로 데이터를 전달해야할 때 적용할 수 있는 패턴입니다.

하이라이트 되어있는 **1번**, **18번** 줄은 뒤에서 좀 더 자세히 분석 해보도록 하고, 전체적인 코드를 한번 분석해보겠습니다.

**13번째 줄**: 맨 처음 A에서 B로 전환될 때 B의 대리자로 A를 선택합니다.

**21번째 줄**: B에서 다시 A로 전환될 때(예시 코드에서는 secondVC의 sendData) 대리자의 함수를 호출해줍니다.

**29번째 줄**: 그러면 firstVC의 num이 20으로 바뀌어있는 것을 볼 수 있습니다!

다시 한번 정리하자면,

> A에서 B로 넘어갈때 대리자를 임명하고 B에서는 대리자의 함수를 호출한다!

라는 것이 기본적인 ~~Delegate Pattern~~의 개념이 되겠습니다. 

## AnyObject란?
<pre class="line-numbers language-swift" data-line="1">
<code>protocol changing: AnyObject {
    func getData(plus n: Int)
}</code>
</pre>

그럼 왜 **Protocol**이 **AnyObject**를 상속받았을까요?

먼저 **AnyObject**를 상속받는게 어떤 의미인지 알아야할 필요가 있습니다.

~~Protocol~~은 Class, Struct, Enum에서 채택할 수 있다고 배웠는데요, AnyObject를 상속받은 Protocol은 ~~Class에서만 채택~~할 수 있게 됩니다.

그렇다면 왜 클래스에서만 채택하게끔 만드는 것일까요?

그 이유는 위에서 하이라이트된 **18번 줄**과 관련이 있습니다!

## 왜 Weak?
<pre class="line-numbers language-swift" data-line="2">
<code>class secondVC {
    weak var delegate: changing?

    func sendData() {
        delegate?.getData(plus: 10)
    }
}</code>
</pre>

앞서 **Protocol**이 **AnyObject**를 상속받은 이유를 설명하기 위해선 delegate를 왜 [약한 참조](https://juseok.xyz/posts/Strong) 했는지를  먼저 알아야합니다.

위에서 설명헀듯이 ~~dlegate Pattern~~은 A -> B -> A의 화면 전환에서 주로 사용된다고 했습니다.

따라서 A에서는 B의 객체를 받아 **대리자**를 임명해줘야 하고, B에서는 **A의 객체**를 가지고 있어야 다시 A뷰로 넘어갈 수 있게 됩니다.

이때, B의 대리자가 **강한 참조**라면 A로 화면이 돌아오며 B의 메모리가 해제되어도, B의 대리자는 해제되지 않는 ~~메모리 릭~~이 일어나게 됩니다!

때문에 B의 대리자를 ~~Weak~~으로 선언해주는 것인데요, 그럼 이제 왜 **AnyObject**를 상속 받아야하는지 의문을 풀 수 있습니다.

## 왜 AnyObject?
우리는 ~~ARC~~에 대해 공부할 때 Class, Struct, Enum 중 Class는 **Reference Type**, 나머지는 **Value Type**이라고 배웠습니다.

당연히 참조 키워드를 사용할 수 있는 것은 Class밖에 없겠죠? 때문에 **Protocol**에 **AnyObject**를 상속받아 ~~Class에서만 채택~~할 수 있게 하는 것입니다.

물론, 그 이전에 A와 B에서 **Delegate**를 **얕은복사** 해야지만 정상적으로 값이 바뀌기 때문에 당연히 Class만 채택할 수 있게 해야하기도 합니다.

## Protocol Type
이 부분은 제가 개인적인 의문이 들어 몇 가지 실험을 통해 나름대로 정리한 부분입니다...

<pre class="line-numbers language-swift" data-line="2">
<code>class secondVC {
    weak var delegate: changing?

    func sendData() {
        delegate?.getData(plus: 10)
    }
}</code>
</pre>

예제를 보면 **delegate**를 firstVC 타입이 아닌 changing 즉, ~~프로토콜 타입~~으로 선언한 것을 볼 수 있는데요.

왜 굳이 프로토콜 타입으로 선언했는 지에 대해 의문이 들었습니다.

직접 테스트를 해보니 **delegate**가 firstVC 타입이어도 해당 예제에 한에서는 동일하게 작동하는 것을 확인했습니다.

그럼에도 프로토콜 타입으로 선언하는 이유는 ~~delegate에 있는 프로퍼티만 사용하기 위해서~~ 라고 이해했습니다.  

왜냐하면 firstVC 타입으로 선언하는 경우 firstVC에 있는 num에 **직접 접근**할 수 있게 되고 이는 우리가 목표했던 **기능을 위임하는 Delegate Pattern**이 아니기 때문입니다. 

## 마무리 정리
~~Delegate Pattern~~은 특정 기능 다른 객체로 위임해 해당 객체에서 수행하게끔 하는 패턴입니다.

주로 **A -> B -> A**로 화면이 전환될 때 사용합니다. 

혹시나 오류나 문제가 있다면 댓글로 지적부탁드립니다.

## 참고자료
<ul>
<li>
    <a href="https://fomaios.tistory.com/entry/iOS-%EB%A9%B4%EC%A0%91%EC%A7%88%EB%AC%B8-Delegate%EB%8A%94-retain%EC%9D%B4-%EB%90%A0%EA%B9%8C">Fomagran</a>
</li>
<li>
    <a href="https://velog.io/@zooneon/Delegate-%ED%8C%A8%ED%84%B4%EC%9D%B4%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%BC%EA%B9%8C">zooneon.log</a>
</li>
</ul>
