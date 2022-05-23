---
date: 2022년 05월 22일 23:37
description: loadView와 viewDidLoad의 차이
oneline: loadView를 언제 쓰는게 유용할까?
tags: iOS, Swift
thumbnail: /images/vclifecycle.jpg
contents: 서론/View Life Cycle/loadView/viewDidLoad/정리
file: LoadView
---

## 서론

여느때와 다름없이 깃헙으로 다른 사람들의 소스를 염탐하던 중 ~~loadView()~~에서 커스텀 뷰를 생성하는 코드를 보게 되었습니다.

평소에 ~~viewDidLoad~~에서 UI를 그리고 추가하는 코드를 작성하던 저는 **loadView**와 **viewDidLoad**의 차이점에 대해 궁금해졌습니다.

이를 알기 위해 먼저 ~~View Life Cycle~~에 대해 간단히 알아보겠습니다. 

## View Life Cycle

**View Controller의 생명주기** 라고도 하는 **View Life Cycle**은 말 그대로 **View Controller**가 어떤 순서대로 보여졌다 사라지는지를 의미합니다.

<img style="width: 300px;margin: auto;display: block;" alt="vclifecycle" src="/images/vclifecycle.jpg"/>

위 사진이 바로 View Controller의 생명 주기를 나타냅니다. 

이 중 [viewDidUnload](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621383-viewdidunload)는 **Deprecated** 된 것 같으니 나머지를 알아보면,

~~loadView~~ -> 뷰를 로드한다.

~~viewDidLoad~~ -> 뷰가 로드 되었다.

~~viewWillAppear~~ -> 뷰가 나타날 것이다.

~~viewDidAppear~~ -> 뷰가 나타났다.

~~viewWillDisappear~~ -> 뷰가 사라질 것이다.

~~viewDidDisappear~~ -> 뷰가 사라졌다.

순서를 보면 loadView가 더 먼저 호출되는 것을 볼 수 있는데요, 도대체 loadView는 어떤 역할을 하는 함수일까요?

## loadView

애플 개발자 문서에선 loadView를 아래와 같이 정의합니다.

<img alt="loadview" src="/images/loadview.png"/>

> 컨트롤러가 관리하는 뷰를 만듭니다.

컨트롤러가 관리하는 뷰는 바로 우리가 자주 VC의 뷰에 접근하기 위해 자주 사용하던 ~~self.view~~, 이 녀석입니다.

추가적으로 [Discussion](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview)에는 loadView의 사용 주의사항이 적혀있는데요.

제 나름대로 이해한 내용을 정리해보자면, **loadView**는 viewController가 관리하는 메소드입니다.

viewController는 현재 뷰가 nil일 때 **loadView** 호출합니다. 

**loadView**는 기본적으로 사용자가 생성한 뷰를 가져와서 이를 viewController의 뷰(수퍼뷰)로 설정합니다.

따라서 인터페이스 빌더(스토리보드)를 사용하여 화면을 구성한 경우 **loadView**를 재정의하면 안됩니다.

View를 코드로 구현한 경우엔 **loadView**를 재정의할 수 있습니다.

이처럼 ~~loadView~~에서는 수퍼뷰의 초기화와 관련된 코드가 작성되는 것이 적합해 보입니다.

## viewDidLoad

애플 개발자 문서에선 viewDidLoad를 아래와 같이 정의합니다.

<img alt="viewdidload" src="/images/viewdidload.png"/>

> 컨트롤러의 뷰가 메모리에 로드된 후 호출됩니다.

마찬가지로 [Discussion](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload)을 읽어보면,

이 메서드는 뷰 컨트롤러가 뷰 계층 구조를 메모리에 로드한 후에 호출됩니다. 

이 메서드는 뷰 계층 구조가 nib 파일에서 로드되었는지 또는 **loadView** 메서드에서 프로그래밍 방식으로 생성되었는지 여부에 관계없이 호출됩니다.

일반적으로 이 메서드를 재정의하여 nib 파일에서 로드된 뷰에 대한 **추가 초기화**를 수행합니다.

즉, 수퍼뷰가 생성된 후 그 위에 어떠한 작업을 하기 위한 코드가 작성되는 것이 적합해 보입니다.

## 정리

처음 loadView를 봤을 땐 혹시 UI를 그리는 코드가 여기에 포함되어야하나? 하는 생각이 들었는데, 찾아보니 그런 것 같지는 않았습니다.

수퍼뷰를 세팅하는 코드 외에 수퍼뷰 하위에 포함되는 뷰들의 초기화같은 경우엔 ~~viewDidLoad~~에 들어가는게 맞다고 판단했습니다.

혹시나 이해가 안되는 부분, 오류나 문제가 있다면 댓글로 지적부탁드립니다.

## 참고자료
<ul>
<li>
    <a href="https://medium.com/yay-its-erica/viewdidload-vs-loadview-swift3-47f4ad195602">viewDidLoad() vs loadView()</a>
</li>
<li>
    <a href="https://yagom.net/forums/topic/loadview%EC%99%80-viewdidload-%EC%B0%A8%EC%9D%B4%EC%97%90-%EB%8C%80%ED%95%9C-%EC%A7%88%EB%AC%B8%EC%9E%85%EB%8B%88%EB%8B%A4/">야곰닷넷</a>
</li>
</ul>

