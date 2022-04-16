---
date: 2022년 04월 16일 23:30
description: VIPER 패턴이란 무엇인가?
oneline: 아키텍처는 너무 어려워!
tags: iOS, Swift
thumbnail: /images/viperinfo.png
contents: VIPER 아키텍처/왜 VIPER?/VIPER의 View/VIPER의 Presenter/VIPER의 Router/VIPER의 Inspector/VIPER의 Entity/정리
file: ProtocolDeep
---

## VIPER 아키텍처

~~VIPER~~는 View, Interactor, Presenter, Entity, Router로 이루어진 **아키텍처**입니다.

어느정도 어플리케이션을 개발하다보면 **MVC**, **MVVM**와 같은 아키텍처 패턴에 대해 접하게 되는데요, 이러한 아키텍처들이 왜 필요한 것일까요?

> 좋은 아키텍처 패턴을 가진 소프트웨어는 기능을 추가하거나 수정하기 쉽고, 결국 이것은 비용적인 측면에서도 중요하다.

많은 사람들이 말하는 **아키텍처의 중요성**입니다.

아무래도 하나의 기능을 추가, 수정하는 것이 쉽다는 것은 그만큼 시간이나 인적자원이 덜 든다는 것이고 적은 비용으로 유지보수를 할 수 있음을 의미하기 때문이죠.

이번 포스팅에서는 수많은 아키텍처 중 ~~VIPER~~에 대해 알아보겠습니다. 

## 왜 VIPER?

최근 취준을 하며 채용공고를 찾아볼 일이 많아졌는데요, 우대사항에 ~~RIBs~~ 또는 ~~VIPER~~에 대한 내용이 기술되어 있는 회사를 심심치않게 볼 수 있었습니다.

사실 ~~MVVM~~에 대해 공부할 때도 비슷한 키워드는 정말 많이 봤었는데 도저히 엄두가 나지 않다가 평생 모를 수는 없을 것 같아 공부를 시작하게 되었습니다.

보통 아키텍처는 기존의 아키텍처의 불편함이나 문제점을 보안하며 발전하는 듯 하는데요, 

**VIPER**는 [책임 분리의 원칙(SRP)](https://ko.wikipedia.org/wiki/%EB%8B%A8%EC%9D%BC_%EC%B1%85%EC%9E%84_%EC%9B%90%EC%B9%99)를 지키기 때문에 **MV(X)패턴**에 비해 클린한 코드를 작성할 수 있다 합니다. 

<img alt="viperinfo" src="/images/viperinfo.png"/>

위 사진은 ~~VIPER~~의 역할을 제가 이해한대로 적어본 것입니다.

예를 들어 버튼을 클릭해 화면을 전환하는 기능을 추가한다고 했을 때를 생각해 봅시다.

먼저, **View**에서 Button을 생성하고 **Presenter**에서 Button의 Action을 처리할 함수를 만듭니다.

그 다음 **Router**에서 화면을 전환하는 함수를 만들고 이 함수를 **Presenter**에 만들어 논 Button의 Action을 처리하는 함수에서 호출합니다.

이러한 일련의 과정은 모두 [Delegate Pattern](https://juseok.xyz/posts/ProtocolDeep)을 통해 구현됩니다.

그럼 직접 예시에 맞는 예제 코드를 보며 분석해보도록 하겠습니다.

> **예제 코드는 설명에 필요한 부분만 가져왔으며 전체 코드는 [링크](https://github.com/MojitoBar/VIPER-Study)를 통해 확인해 볼 수 있습니다.**

## VIPER의 View

<pre class="language-swift line-numbers">
<code>protocol UserViewUpdatable {
    var presenter: UserPresentable? { get set }
}

class UserViewController: UIViewController, UserViewUpdatable {
    var presenter: UserPresentable?

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showUserDetail(userInfo: users[indexPath.row])
    }
}</code>
</pre>

우리는 테이블 뷰를 하나 만들고 셀을 클릭 시 클릭된 셀의 정보를 가지고 다음 뷰로 넘어가려고 합니다.

위에서 설명 했듯이 ~~View~~에서는 Delegate Pattern을 위해 ~~UserViewDpdatable~~이라는 **protocol**을 채택해줬고, 셀을 클릭시 ~~presenter~~의 **showUserDetail**함수에 셀의 정보를 담아 호출해줬습니다.

## VIPER의 Presenter

<pre class="language-swift line-numbers">
<code>protocol UserPresentable {
    var router: UserRoutable? { get set }
    
    func showUserDetail(userInfo: User)
}

class UserPresenter: UserPresentable {
    var router: UserRoutable?
    
    func showUserDetail(userInfo: User) {
        router?.showUserDetail(userInfo: userInfo)
    }
}</code>
</pre>

~~Presenter~~에서는 ~~View~~의 Action을 처리해준다고 했는데요,

마찬가지로 UserPresentable 프로토콜을 채택하여 기능의 수평 확장성을 높혔습니다.

~~View~~에서 넘어온 정보를 가지고 ~~Router~~에 있는 **showUserDetail** 함수를 호출해 줍니다.

## VIPER의 Router

<pre class="language-swift line-numbers">
<code>protocol UserRoutable {
    func showUserDetail(userInfo: User)
}

class UserRouter: UserRoutable {
    func showUserDetail(userInfo: User) {
        guard let navigationController = entry?.navigationController else { return }
        
        let userDetailVC: UIViewController & UserDetailUpdatable = UserDetailView()
        userDetailVC.initialName(user: userInfo)
        navigationController.pushViewController(userDetailVC, animated: true)
    }
}</code>
</pre>

마지막으로 ~~Router~~에서는 ~~Presenter~~에서 넘어온 정보를 가지로 다음 뷰로 넘어가는 코드를 작성해줍니다.

그럼 아래와 같은 결과물을 확인 할 수 있습니다!!

<img style="width: 300px;margin: auto;display: block;" alt="viperinfo" src="/images/viperexample.gif"/>

## VIPER의 Inspector

위에서 예로 든 상황을 구현하기 위한 코드는 알아봤고 남은 녀석들의 역할도 마저 알아보겠습니다.

~~Inspector~~는 API에 관련된 역할을 하는 친구라 했는데요,

<pre class="language-swift line-numbers">
<code>protocol UserInteractorable {
    var presenter: UserPresentable? { get set }
    
    func getUsers()
}

class UserInteractor: UserInteractorable {
    var presenter: UserPresentable?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            if let entities = try? JSONDecoder().decode([User].self, from: data) {
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            }
            else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
            }
        }
        task.resume()
    }
}</code>
</pre>

비교적 코드 이해가 쉽죠...? (API는 [JSONPlaceholder](https://jsonplaceholder.typicode.com/)를 이용해서 테스트했습니다!)

마찬가지로 ~~UserInteractorable~~ 프로토콜을 채택하고 API를 호출합니다.

파싱한 데이터는 ~~Presenter~~의 **interactorDidFetchUsers** 함수로 넘겨서 ~~View~~를 새로고침할 준비를 하게 됩니다.

## VIPER의 Entity

<pre class="language-swift line-numbers">
<code>struct User: Codable {
    let name: String
}</code>
</pre>

하찮은 ~~Entity~~...ㅎㅎ

모델에 관한 코드가 작성되어 있습니다.

## 정리

이번엔 ~~VIPER~~ 아키텍처를 화면 전환하는 기능을 예시로 코드를 분석하는 방식으로 정리해봤습니다.

[예제 코드](https://github.com/MojitoBar/VIPER-Study)를 확인해보면 어플이 시작되는 ~~EntryPoint~~를 지정하는 코드와 API를 패치해 View를 새로 고침하는 코드도 확인해 볼 수 있습니다!

당장 프로젝트에 적용하기에는 아직 미숙하지만 ~~VIPER~~에 대한 개념정도는 어느정도 이해한 것 같습니다.

직접 구현해보니 프로젝트에 맞는 아키텍처는 있지만 무조건 좋은 아키텍처는 없다는 말이 어떤 뜻인지 알 것 같습니다.

혹시나 오류나 문제가 있다면 댓글로 지적부탁드립니다.

## 참고자료
<ul>
<li>
    <a href="https://www.youtube.com/watch?v=hFLdbWEE3_Y&lc=Ugy4LCD7BWkJJNgvgTl4AaABAg.9SvqJFIDYol9_I3WFtGzcF">iOS Academy</a>
</li>
<li>
    <a href="https://dongminyoon.tistory.com/42">동동이's tistory</a>
</li>
</ul>
