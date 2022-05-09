---
date: 2022년 05월 09일 09:05
description: RxSwift를 이용해 TextField 자동완성 구현하기
oneline: 근데 이제 RxDataSources를 곁들인...
tags: iOS, Swift
thumbnail: /images/rxswift.jpg
contents: 서론/TableView With RxDataSources/TableView에 데이터 바인딩하기/TextField With RxSwift/정리
file: RxSearchBar
---

## 서론

이번 포스팅에서는 ~~TextField~~에서 검색어를 입력하면 그에 맞게 테이블 뷰의 아이템을 변경하는 것을 해보려합니다.

이를 ~~RxSwift~~를 이용해 구현해봤는데요, **RxSwift**에 대한 내용보다는 기능 구현에 포커스를 맞추려합니다.

**RxSwift**에 대한 내용은 정리하기엔 이해도가 너무 낮기도 하고 너무 좋은 자료들이 있기 때문에 더 나중에 기회가 되면 정리해보도록 하겠습니다.

아래는 제가 **RxSwift**를 공부하며 참고한 자료들입니다.

**너무 좋은 자료**

- [곰튀김님의 RxSwift 4시간에 끝내기](https://www.youtube.com/watch?v=iHKBNYMWd5I&t=8517s)

- [Wallaby님과 함께하는 RxSwift](https://www.notion.so/Wallaby-RxSwift-72194669a39a4557baa69c672268af38)

## TableView With RxDataSources

먼저 **TableView**를 구현해봅시다.

UIKit으로 TableView를 구현한다면, TableView의 **Delegate**, **DataSource**를 채택해 각 Cell들이나 로직을 구현했을텐데요.

이번엔 ~~RxDataSources~~를 이용해 구현해 보겠습니다.

<pre class="language-swift line-numbers">
<code>import RxDataSources

let dataSource = RxTableViewSectionedReloadDataSource<섹션데이터>(configureCell: { dataSource, tableView, indexPath, item in
    let cell = tableView.dequeueReusableCell(withIdentifier: 커스텀셀.cellId, for: indexPath) as! 커스텀셀
    return cell
})</code>
</pre>

~~RxTableViewSectionedReloadDataSource~~을 이용해 TableView에 Cell를 구현해주면 되는데요, **섹션데이터**는 우리가 보여줄 Cell의 정보를 가지고 있습니다.

> 커스텀셀은 UIKit으로 구현하던 방식과 동일하게 구현했습니다.

<pre class="language-swift line-numbers">
<code>struct 섹션데이터 {
    var header: String
    var items: [Item]
}

extension 섹션데이터: AnimatableSectionModelType {
    typealias Item = Person
    
    init(original: 섹션데이터, items: [모델]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}</code>
</pre>

위 코드는 **섹션데이터 코드**입니다. 섹션데이터는 TableView의 하나의 섹션을 의미합니다.

즉 header는 TableView Section의 header, items는 하나의 Section안에 데이터 배열을 의미합니다.

DataSource에서 사용하는 섹션데이터는 ~~AnimatableSectionModelType~~형을 준수해야합니다.

**AnimatableSectionModelType**은 ~~SectionModelType 프로토콜~~과 ~~IdentifiableType 프로토콜~~을 준수하고 있는데요,

SectionModelType은 말 그대로 섹션이 하는 역할을 가지고 있고, IdentifiableType은 각 셀의 애니메이션을 구분하기 위해 고유한 아이디 값을 가져야한다는 역할을 가지고 있습니다.

이렇게 구현을 하고보면 모델이 ~~IdentifiableType~~, ~~Equatable~~를 준수해야한다는 오류를 볼 수 있습니다.

<pre class="language-swift line-numbers">
<code>struct 모델 {
    var name: String
    var phoneNumber: String
}

extension 모델: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}</code>
</pre>

따라서 모델의 extension으로 IdentifiableType, Equatable를 채택했고, 모델의 identity를 UUID로 지정했습니다.

드디어 dataSource에 필요한 코드를 모두 알아봤습니다.

## TableView에 데이터 바인딩하기

위에서 구현한 dataSource를 TableView에 연결하는 방법에 대해 알아보겠습니다.

```swift
모델Observable = BehaviorRelay<[섹션데이터]>(value: [])
```

이 프로젝트에서는 실제 주소록의 데이터를 테이블 뷰로 보여줄 것이기 때문에 TableView에 바인딩할 데이터를 **RxSwift**의 ~~BehaviorRelay~~를 이용해 선언해줬습니다.

<pre class="language-swift line-numbers">
<code>모델Observable
    .bind(to: tableView.rx.items(dataSource: dataSource))
    .disposed(by: disposeBag)</code>
</pre>

그 다음 bind를 통해 tableView의 아이템을 위에서 선언한 **dataSource**로 설정해줍니다.

이렇게 하면 일단 tableView는 끝났습니다.

순서를 정리해보자면,

- tableView와 커스텀셀은 기존의 방법으로 구현합니다. 

- tableView에 연결할 dataSource를 ~~RxTableViewSectionedReloadDataSource\<섹션데이터\>~~로 생성합니다.

- 이때, 섹션데이터는 tableView의 하나의 섹션을 의미하며 나중에 바인딩할 Observable의 타입이 될 것입니다.

- 섹션데이터는 ~~AnimatableSectionModelType~~를 준수해야하며 섹션데이터 안의 item타입은 IdentifiableType, Equatable를 준수해야합니다.

- 데이터를 바인딩할 Observable를 생성한 뒤 우리가 만들어준 ~~dataSource~~를 바인딩합니다.

아직 100% 이해하지 못해서 정리를 완벽하게 하지 못한 것 같네요..

아래 코드 링크를 남겨놓을테니 직접 한번 보시면 그렇게까지 어렵진 않을거 같습니다... ㅎㅎ


## TextField With RxSwift

다음으로 TextField를 ~~RxSwift~~로 구현해 봅시다!

기존의 방식이라면 TextField의 delegate를 채택해 입력에 관한 로직을 구현했을텐데요,

RxSwift를 활용하면 조금 더 간편하게 구현할 수 있습니다.

<pre class="language-swift line-numbers">
<code>searchBar.rx.text
    .orEmpty
    .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
    .subscribe(onNext: { [weak self] changedText in
        if self?.searchBar.text! != "" {
            모델Observable.accept(필터 된 데이터)
        }
        else {
            모델Observable.accept(필터 안 된 데이터)
        }
    })
    .disposed(by: disposeBag)</code>
</pre>

searchBar라는 TextField를 선언한 후 **rx.text**로 접근하면 별도의 delegate를 채택하지 않아도 텍스트가 변경될 때마다 체크할 수 있습니다.

변경된 텍스트는 **Optional** 타입으로 받아오는데요, **Optional**을 없애기 위해 ~~orEmpty~~를 사용했고,

~~debonce~~를 200밀리세컨드로 설정했습니다.

이후에 텍스트가 변경되면 뭘 할 것인지 작성하면 되는데요, textField에 값이 있을 때만 그에 맞는 필터 된 데이터를 보여주고 입력 값이 없다면 전체 데이터를 보여주도록 했습니다.

<img style="display: block; margin: auto; width: 200px;" alt="rxsearchbar" src="/images/rxsearchbar.gif"/>

## 정리

위에서 다룬 전체 소스는 [여기](https://github.com/MojitoBar/HappyDay)를 참고하면 됩니다!

이번에 새로운 프로젝트를 진행하며 처음으로 ~~RxSwift~~를 도입해봤는데요, 왜 러닝커브가 높다고 하는지 알 것 같네요...

혹시나 이해가 안되는 부분, 오류나 문제가 있다면 댓글로 지적부탁드립니다.

## 참고자료
<ul>
<li>
    <a href="https://velog.io/@dvhuni/UITextField%EC%97%90%EC%84%9C-rx.text%EB%A1%9C-%EB%B3%80%EA%B2%BD%EB%90%9C-%ED%85%8D%EC%8A%A4%ED%8A%B8%EB%A5%BC-%EA%B0%90%EC%A7%80%ED%95%98%EA%B8%B0">dvhuni's velog</a>
</li>
<li>
    <a href="https://nsios.tistory.com/32">Nams의 iOS일기</a>
</li>
</ul>
