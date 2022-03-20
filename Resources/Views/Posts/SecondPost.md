---
date: 2022-03-13 23:12
description: Strong, Weak, Unowned?
tags: iOS, Swift
thumbnail: /images/strongImage.png
---

## Strong, Weak, Unowned?
### 이 세가지 키워드는 모두 참조에 관한 키워드입니다.
### <b class="bold">Strong</b>, <b class="bold">Weak</b>는 단어만 봤을 땐 뭔가 강하고 약한 것을 의미하는 것 같은데요, <b class="bold">Unowned</b>는 어떤 의미인지 감이 잘 안잡히기도 합니다.
### 이번에는 세 키워드가 하는 역할과 차이에 대해 알아보려 합니다.

## Strong
### 말 그대로 "강한" 참조를 의미합니다.
### 앞서 <b class="heavy">Unowned</b>ARC에 대한 포스팅에서 <b class="heavy">ARC</b>라는 것은 메모리 할당과 해제를 자동으로 해주는 <b class="heavy">Swift의 기능</b>이라고 설명한 적이 있는데요.
### 그러면서 ARC가 증가할 때가 바로 <b class="heavy">Strong 참조</b>를 할 때 라고 한번 언급한 적이 있습니다.
### 예제 코드와, 그림을 보며 간단히 설명 해보겠습니다.

<pre class="language-swift line-numbers" data-line="1,4,5">
<code>class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var kim = Person(name: "kim")</code>
</pre>

### 위와 같은 코드가 있다고 가정해봅시다.
### 그러면 아래 그림과 같이 메모리의 할당이 일어나게 될 것입니다.


<br/>


<img src="/images/strongImage.png"/>


<br/>


### 이처럼 힙 영역에 할당된 메모리를 참조하여 RC가 증가하게하는 참조 방법이 Strong, <b class="heavy">강한 참조</b>입니다.
### 하지만 강한 참조에는 한가지 문제점이 있는데요, 그것이 바로 <b class="heavy">순환 참조</b>입니다.

## 순환 참조
### 말 그대로 참조가 순환되는 경우를 말하는데요, 아래 코드와 그림을 통해 알아보겠습니다.

<pre class="language-swift line-numbers" data-line="1,3">
<code>class Person {
    let name: String
    var friend: Person?
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}</code>
</pre>

```swift
var kim: Person? = Person(name: "kim")
var lee: Person? = Person(name: "lee")

kim?.friend = lee
lee?.friend = kim
```

### 이번에는 <b class="heavy">Person 클래스</b>에 <b class="heavy">friend</b>라는 프로퍼티를 추가했습니다.
### 그리고 kim과 lee는 서로 친구를 하기로 했는데요.
### 이 경우엔 아래와 같은 그림처럼 메모리가 할당될 것입니다.


<br/>
<img src="/images/strong2Image.png"/>
<br/>


### kim과 lee의 friend 프로퍼티가 각각 lee와 kim을 참조하게 되며 RC가 하나씩 더 카운트 된 것을 볼 수 있습니다.
### 이처럼 두개의 객체 서로가 서소를 참조하고 있는 형태를 <b class="heavy">순환 참조</b>라고 합니다.
### 문제는 여기서 발생하는데요, 만약 kim과 lee둘이 모종의 사고(?)로 더 이상 존재하지 않는다고 생각해봅시다.

```swift
kim = nil
lee = nil
```

### 과연 위 코드를 실행하면 kim과 lee의 deinit이 호출될까요?

### <b class="heavy">정답은 호출되지 않는다 입니다.</b> 그 말은 힙에서 메모리가 제대로 해제되지 않았다는 뜻인데요.
### 어떻게 생각하면 당연한 결과입니다. kim, lee가 nil이 되며 그들이 가르키고 있던 참조는 해제되었지만, 그들의 프로퍼티가 가르키고 있는 참조는 해제되지 않았기 때문입니다.
### 따라서 이경우에 어플이 종료될 때 까지 <b class="heavy">메모리 릭</b>이 발생하게 될 것입니다.

<br/>

### 물론 먼저 friend를 nil로 할당한 후 kim, lee를 nil로 할당한다면 정상적으로 메모리가 해제되어 deinit이 호출됩니다.
### 하지만 friend같은 프로퍼티가 하나가 아니라 수십개 이거나 순환 참조를 해야하는 경우가 빈번하다면 일일히 해제해주는 방법은 그리 좋은 방법이 아닙니다.
### 이를 해결하기 위해 <b class="heavy">Weak</b>, <b class="heavy">Unowned</b>를 사용하면 됩니다.

## Weak
### 약한 참조는 인스턴스를 참조할 시, RC를 증가시키지 않고, 참조하던 인스턴스가 메모리에서 해제된 경우, 자동으로 nil이 할당되어 메모리가 해제되는 기능을 합니다.
### 나중에 nil이 할당되며 메모리가 해제된다는 점에서 weak 키워드의 변수는 <b class="heavy">무조건 옵셔널 타입</b>의 변수여야합니다.
### 코드와 그림을 통해 알아보겠습니다.

```swift
class Person {
    let name: String
    weak var friend: Person?
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var kim: Person? = Person(name: "kim")
var lee: Person? = Person(name: "lee")

kim?.friend = lee
lee?.friend = kim

kim = nil
lee = nil
```

### 아까와 동일한 코드에서 <b class="heavy">friend</b> 프로퍼티에 <b class="heavy">weak</b>을 적용했습니다.
### 그럼 아래 그림과 같이 각각의 friend의 참조는 RC에 영향을 주지 않기 떄문에 각각 1씩만 증가한 것을 볼 수 있습니다.

<br/>
<img src="/images/weakImage.png"/>
<br/>

### 여기서 kim과 lee가 nil이 된다면 RC가 1씩 감소하게 되고, 둘 다 RC가 0이 되기 때문에 정상적으로 힙 메모리에서 해제되는 것을 볼 수 있습니다.

## Unowned
### 그렇다면 Unowned는 무엇일까요?
### <b class="heavy">Unowned</b>는 미소유 참조로 불리며 큰 틀에서 하는 역할은 <b class="heavy">weak와 동일</b>합니다.
### RC 값을 증가시키지 않아 강한 순환 참조를 해결할 수 있는데요, weak과의 차이점은 unowned는 <b class="heavy">인스턴스를 참조하는 도중에 해당 인스턴스가 메모리에서 사라질 일이 없다고 확신한다는 점입니다.</b>

<br/>

### 이게 무슨 말이냐면, <b class="heavy">weak</b>의 경우 kim이 nil이 되었을 때 자동으로 lee의 friend를 nil로 초기화 합니다.
### 하지만 <b class="heavy">unowned</b>의 경우 kim이 nil이 되어도 lee의 friend를 nil로 초기화하지 않고 계속해서 주소를 참조합니다.
### <b class="heavy">이 경우 kim이 가르키고 있던 0x111111의 RC가 0이 되어 힙 영역에서 해제되었으므로 lee가 가르키는 friend는 해제된 메모리를 참조하게 됩니다.</b>
### 따라서 오류가 발생하게 되며 이것이 <b class="heavy">weak</b>과 <b class="heavy">unowned</b>의 차이점입니다.


<br/>
<br/>

### 여기까지 <b class="bold">Strong</b>, <b class="bold">Weak</b>, <b class="bold">Unowned</b>에 대해 한 번 알아보았는데요, 이해는 했지만 코드에 금방 적용시킬 수 있을 지는 의문이듭니다.
### 혹시나 오류나 문제가 있다면 하단에 적힌 메일로 지적부탁드립니다.

<br/>
<br/>
## 참고자료
<ul>
<li>
    <a href="https://babbab2.tistory.com/27">개발자 소들이</a>
</li>
</ul>
