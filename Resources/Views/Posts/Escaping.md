---
date: 2022년 06월 21일 14:35
description: Escaping(탈출) 클로저란?
oneline: 탈출 클로저와 비동기 프로그래밍의 관계
tags: iOS, Swift
thumbnail: /images/swiftlogo.png
contents: 서론/Escaping Closure/정리
file: Escaping
---

## 서론

이번 포스팅에서는 ~~Escaping Closure~~ 즉, **탈출 클로저**에 대해 알아보겠습니다.

이 포스팅에서는 **클로저**에 대한 기본적인 내용은 다루지 않습니다.

**탈출 클로저**와 **비동기 프로그래밍**의 관계에 더욱 초점을 두고 정리하였습니다.

## Escaping Closure

탈출 클로저는 이름에서도 알 수 있듯이 ~~어딘가를 탈출~~하는 클로저입니다.

어딘가는 바로 **함수 스코프**인데요, 왜 함수를 탈출해야 할까요?

보통은 비동기 작업을 하기 위해서 클로저를 탈출시킵니다. (이외에 탈출 클로저를 사용해야만 하는 예시가 있다면 알려주시면 감사드립니다.)

예제를 보며 설명하겠습니다.

<pre class="language-swift line-numbers" data-line="3-5">
<code>func signin(email: String, password: String, completion: @escaping () -> Void) {
    // 시간이 걸릴 수 있는 작업 (ex. API 호출 등)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        completion()
    }
    
    print(email)
    print(password)
}

signin(email: "email", password: "password") {
    print("작업 완료, 이후에 할 행동")
}</code>
</pre>

여기 이메일, 패스워드 그리고 탈출 클로저를 매개변수로 받는 ~~signin 함수~~가 있습니다.

프로그램 어딘가에서 로그인을 한다고 생각해봅시다.

로그인 API와 같이 시간이 걸릴 수 있는 작업의 경우(예제에서는 3-5번 하이라이트) 함수가 끝날 때까지 기다리면 성능상 이슈가 생길 수 있기 때문에 ~~비동기~~로 작업합니다.

그러면 결과를 받아오기전에 signin 함수가 끝날 수도 있게 되어 저희가 원하는 API 결과값도 함께 사라지게 되는데요, 

이때 ~~탈출 클로저~~를 사용하면 함수의 스코프에 구애받지않고 탈출해서도 유효한 작업을 할 수 있게 됩니다.

따라서 위 예제의 결과 값은 아래와 같습니다.

<pre class="language-swift line-numbers">
<code>email
password
작업 완료, 이후에 할 행동</code>
</pre>

## 정리

**클로저**를 탈출 시킴으로 얻을 수 있는 특징은 크게 **두 가지**가 있습니다.

1. ~~해당 클로저를 외부 변수/상수에 저장 가능합니다.~~ (일반 클로저의 경우 유효범위가 함수 내부 스코프임.)

2. ~~해당 함수가 끝나서 리턴된 이후에도 클로저 실행이 가능합니다.~~

거의 모든 API 라이브러리가 비동기로 작성되어있는 만큼 탈출 클로저의 이해도가 높아야한다고 생각합니다.

이번 포스팅을 통해 어느정도 개념을 이해했으니 앞으로는 이해 못한 채 사용하는 경우가 없도록 해야겠습니다.

혹시나 오류나 문제가 있다면 댓글로 지적부탁드립니다.

## 참고자료
<ul>
<li>
    <a href="https://i-colours-u.tistory.com/17">i-colours-u</a>
</li>
</ul>
