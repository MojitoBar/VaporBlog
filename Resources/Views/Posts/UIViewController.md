---
date: 2022년 06월 13일 09:06
description: UIViewController 란?
oneline: UIKit 앱의 뷰 계층 구조를 관리하는 개체
tags: Swift, iOS
thumbnail: /images/swiftlogo.png
contents: UIViewController/View Management/Data Marshaling/Handling View-Related Notifications/정리
file: UIViewController
---

## UIViewController 란?

이번 포스팅에서는 기술 면접에서 종종 나오는 ~~UIViewController~~에 대해 알아보겠습니다.

<img alt="uiviewcontroller" src="/images/uiviewcontroller.png"/>

> UIViewController 클래스는 모든 뷰 컨트롤러에 공통적인 공유 동작을 정의합니다. UIViewController 클래스의 인스턴스를 직접 만드는 경우는 거의 없습니다. 대신 UIViewController의 하위 클래스를 만들고 뷰 컨트롤러의 뷰 계층 구조를 관리하는 데 필요한 메서드와 속성을 추가합니다.

공식 문서를 보니 모든 **"뷰 컨트롤러에 공통적인 공유 동작을 정의하는 클래스"** 라 명시되어 있습니다.

그럼 더욱 자세하게 ~~UIViewController~~가 하는 역할에 대해 알아보겠습니다.

## View Management

먼저 ~~뷰 계층~~을 관리하는 역할입니다.

<img alt="rootview" src="/images/rootview.png"/>

위 그림과 같이 모든 뷰 컨트롤러는 **Root View**를 가지고 있으며, 화면에 표시하기 위해서는 **Root View**에 속해있어야합니다.

뷰 컨트롤러에 뷰를 지정하는 방법에는 크게 3가지가 있습니다.

- StoryBoard를 이용하는 방법
- Nib 파일을 이용하는 방법 (StoryBoard와는 다르게 VC간의 관계를 지정할 수 없으며 VC자체의 최소한의 정보만 저장.)
- loadView() 메서드를 이용하는 방법

## Data Marshaling

다음으로 뷰 컨트롤러는 관리하는 뷰와 앱 데이터 사이의 ~~중개자~~ 역할을 합니다. (EX. MVC 패턴)

<img alt="mvc" src="/images/mvc.png"/>

뷰 컨트롤러와 데이터 개체는 항상 명확한 책임 분리를 유지해야 합니다.

데이터 구조의 무결성을 보장하기 위한 대부분의 로직은 데이터 개체에 속합니다. 

## Handling View-Related Notifications

다음으로 뷰의 ~~생명주기~~를 핸들링합니다.

뷰의 상태가 변경되면 뷰 컨트롤러는 자동으로 자체 메서드를 호출하여 하위 클래스가 변경 사항에 응답할 수 있습니다.  

~~viewWillAppear()~~와 같은 메서드를 사용하여 화면에 표시되도록 뷰를 준비하고 ~~viewWillDisappear()~~를 사용하여 변경 사항이나 기타 상태 정보를 저장합니다.

아래 그림이 뷰의 상태가 변경될 때 실행되는 자체 메서드들 입니다.

<img alt="lifecycle" src="/images/lifecycle.png"/>

## 정리

위에서 알아본 뷰 컨트롤러의 대표적인 역할을 간략하게 4가지로 정리하면,

- 일반적으로 기본 데이터 변경에 대한 응답으로 보기의 내용을 업데이트합니다.
- 보기와 사용자 상호 작용에 응답을 관리합니다.
- 보기 크기 조정 및 전체 인터페이스 레이아웃 관리합니다.
- 앱에서 다른 보기 컨트롤러를 포함한 다른 개체와 조정합니다.

하나하나 나열해놓고 보면 이해가지만 막상 ~~UIViewController~~가 뭐냐 물으면 간결하게 설명하기가 어려운 것 같습니다..

## 참고자료
<ul>
<li>
    <a href="https://developer.apple.com/documentation/uikit/uiviewcontroller">Apple Developer</a>
</li>
</ul>
