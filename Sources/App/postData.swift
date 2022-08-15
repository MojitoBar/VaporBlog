//
//  File.swift
//  
//
//  Created by judongseok on 2022/03/21.
//
let postDatas: [IndexpostInfo] = [
    IndexpostInfo(title: "부스트캠프 웹 모바일 7기 챌린지 후기",
    context: "앞서 챌린지에 입과하기 위한 코팅테스트의 후기는 여기를 참고해주세요! 7월 18일부터 8월 12일까지 진행한 부스트캠프 챌린지에 대해 간단한 후기와 회고를 남겨보려합니다. 후기 여러 후기에서 다른 일과 병행하기 힘들다는 글을 봤었는데요, 힘든게 아니라 아예 불가능하다고 생각합니다. 여러가지 이유가 있는데요, 일단 매일 주어지는 과제는 말 그대로 챌린지에 초점이 맞춰져있어 주어진 시간에 완벽하게 구현하는게 사실상 불가능합니다. 시간에 맞추기 위해선 항상 어느정도 타협을 해야하고 과제를 수행하기위",
    date: "2022-07-30",
    file: "BoostCampReview",
    tags: [.Swift, .CS],
    thumb: "/images/boostcampintro.png"),
    
    IndexpostInfo(title: "SOLID 완전 정복하기",
    context: "컴퓨터 프로그래밍에서 SOLID란 로버트 마틴이 2000년대 초반에 명명한 객체 지향 프로그래밍 및 설계의 다섯가지 기본 원칙을 마이클 페더스가 두문자어 기억술로 소개한 것입니다. 출처) SOLID 원칙들은 소프트웨어 작업에서 프로그래머가 소스 코드가 읽기 쉽고 확장하기 쉽게 될 때까지 소프트웨어 소스 코드를 리팩토링하여 코드 스멜을 제거하기 위해 적용할 수 있는 지침입니다. 한 마디로 프로그래밍 전략이라 할 수 있죠. SOLID는 SRP, OCP, LSP, ISP, DIP 로 이루어져있는데 지금부터 순서대로 하나씩 알아보겠습니다.",
    date: "2022-07-30",
    file: "SOLID",
    tags: [.Swift, .CS],
    thumb: "/images/solid.png"),
    
    IndexpostInfo(title: "Git의 내부 동작 방식",
    context: "어쩌다 저쩌다 기회가 되서 버전 관리 시스템인 Git이 내부적으로 어떻게 동작하는지와 그 중 Commit이 어떠한 역할을 하는지 디테일하게 알아보게 되었습니다. 깃의 내부 동작 원리 쉽게 말해 로컬 저장소의 변경사항을 기록하는 명령어 입니다. 저는 처음 깃을 사용할 떄는 add와 commit의 차이점을 명확히 알지는 못했는데요, 로컬의 변경 사항을 stage area에 저장하는 키워드가 add라면, commit은 이를 바탕으로 새로운 버전을 생성하는 키워드입니다.",
    date: "2022-07-23",
    file: "GitCommit",
    tags: [.Git],
    thumb: "/images/git.png"),
    
    IndexpostInfo(title: "부스트캠프 웹 모바일 7기 코딩테스트 후기",
    context: "부스트캠프는 네이버커넥트재단에서 운영하는 프로그래밍 부트캠프입니다. 자세한 내용은 홈페이지를 참고해주세요. 간단히 설명하자면 웹 모바일과 AI 분야가 따로 나뉘어져있고, 웹 모바일의 경우 챌린지와 맴버쉽으로 다시 나뉘어집니다. 챌린지를 수료한 후 성적이 좋은 일부가 맴버쉽으로 전환되는거 같더라구요. 저는 이번에 모집한 웹 모바일 7기에 지원했습니다.",
    date: "2022-07-04",
    file: "BoostCampTest",
    tags: [.Swift, .iOS],
    thumb: "/images/boostcamp.jpg"),
    
    IndexpostInfo(title: "Escaping(탈출) 클로저란?",
    context: "이번 포스팅에서는 Escaping Closure 즉, 탈출 클로저에 대해 알아보겠습니다. 이 포스팅에서는 클로저에 대한 기본적인 내용은 다루지 않습니다. 탈출 클로저와 비동기 프로그래밍의 관계에 더욱 초점을 두고 정리하였습니다.",
    date: "2022-06-21",
    file: "Escaping",
    tags: [.Swift, .iOS],
    thumb: "/images/swiftlogo.png"),
    
    IndexpostInfo(title: "UIViewController 란?",
    context: "이번 포스팅에서는 기술 면접에서 종종 나오는 UIViewController에 대해 알아보겠습니다. UIViewController 클래스는 모든 뷰 컨트롤러에 공통적인 공유 동작을 정의합니다. UIViewController 클래스의 인스턴스를 직접 만드는 경우는 거의 없습니다. 대신 UIViewController의 하위 클래스를 만들고 뷰 컨트롤러의 뷰 계층 구조를 관리하는 데 필요한 메서드와 속성을 추가합니다.",
    date: "2022-06-13",
    file: "UIViewController",
    tags: [.Swift, .iOS],
    thumb: "/images/swiftlogo.png"),
    
    IndexpostInfo(title: "WWDC22 Swift Student Challenge 후기",
    context: "Apple은 WorldWide Developers Conference(세계 개발자 컨퍼런스), 이하 WWDC를 매년 개최합니다. 컨퍼런스에서는 애플의 새로운 소프트웨어나 서비스 등의 발표가 이뤄지며 그 외에도 전문가의 만남, Apple Design Awards, Swift Student Challenge 등 여러 행사가 진행됩니다. 저는 그 중 Swift Student Challenge에 참가했고 간단한 후기를 남겨보려 합니다.",
    date: "2022-05-28",
    file: "WWDC22",
    tags: [.Swift, .WWDC],
    thumb: "/images/ssc.png"),
    
    IndexpostInfo(title: "loadView와 viewDidLoad의 차이",
    context: "여느때와 다름없이 깃헙으로 다른 사람들의 소스를 염탐하던 중 loadView()에서 커스텀 뷰를 생성하는 코드를 보게 되었습니다. 평소에 viewDidLoad에서 UI를 그리고 추가하는 코드를 작성하던 저는 loadView와 viewDidLoad의 차이점에 대해 궁금해졌습니다.",
    date: "2022-05-22",
    file: "LoadView",
    tags: [.Swift, .iOS],
    thumb: "/images/vclifecycle.jpg"),
    
    IndexpostInfo(title: "2022 카카오 인턴 코딩테스트 & 2022 프로그래머스 섬머코딩 후기",
    context: "알고리즘을 놓지않고 매주 푼 성과를 보기위해 5월 7일 카카오 인턴쉽, 8일 프로그래머스 섬머코딩에 지원했습니다. 이번 포스팅에서는 각 코딩테스트의 후기를 작성해보려합니다. 그리고 다음부턴 절대 이틀 연속으로 코딩테스트를 잡지 말아야겠습니다 일주일에 하루정도는 쉬기위해서...",
    date: "2022-05-11",
    file: "CodingTest",
    tags: [.Swift, .iOS],
    thumb: "/images/2022kakaobaner.png"),
    
    IndexpostInfo(title: "RxSwift를 이용해 TextField 자동완성 구현하기",
    context: "이번 포스팅에서는 TextField에서 검색어를 입력하면 그에 맞게 테이블 뷰의 아이템을 변경하는 것을 해보려합니다. 이를 RxSwift를 이용해 구현해봤는데요, RxSwift에 대한 내용보다는 기능 구현에 포커스를 맞추려합니다. RxSwift에 대한 내용은 정리하기엔 이해도가 너무 낮기도 하고 너무 좋은 자료들이 있기 때문에 더 나중에 기회가 되면 정리해보도록 하겠습니다.",
    date: "2022-05-09",
    file: "RxSearchBar",
    tags: [.Swift, .iOS],
    thumb: "/images/rxswift.jpg"),
    
    IndexpostInfo(title: "iOS 어플 Gifty 배포 회고",
    context: "이번 포스팅에서는 처음으로 배포하게 된 Gifty 어플에 대한 회고를 작성해보려 합니다. 회고를 작성하기 전에 이번에 배포하게 된 Gifty에 대해서 간단히 소개를 하려 합니다! Gifty는 Apple의 Vision 프레임워크를 주력으로 사용하여 갤러리에 있는 기프티콘 이미지만 뽑아 보여주는 어플입니다. 현재는 앱스토어에서 다운 받을 수 있습니다 ㅎㅎ",
    date: "2022-04-24",
    file: "Gifty",
    tags: [.Swift, .iOS],
    thumb: "/images/gifty.png"),
    
    IndexpostInfo(title: "VIPER 패턴이란 무엇인가?",
    context: "VIPER는 View, Interactor, Presenter, Entity, Router로 이루어진 아키텍처입니다.어느정도 어플리케이션을 개발하다보면 MVC, MVVM와 같은 아키텍처 패턴에 대해 접하게 되는데요, 이러한 아키텍처들이 왜 필요한 것일까요?좋은 아키텍처 패턴을 가진 소프트웨어는 기능을 추가하거나 수정하기 쉽고, 결국 이것은 비용적인 측면에서도 중요하다.많은 사람들이 말하는 아키텍처의 중요성입니다.",
    date: "2022-04-16",
    file: "VIPER",
    tags: [.Swift, .iOS],
    thumb: "/images/viperinfo.png"),
    
    IndexpostInfo(title: "Protocol Delegate 패턴",
    context: "저번 포스팅에서 Protocol에 대한 개인적인 의문점을 해소하며 전반적인 사용법에 대해 알아 봤습니다. 이번 포스팅에서는 지난번에 다루지 못했던 Delegate 패턴에 대해 알아보도록 하겠습니다. Protocol에 대한 배경지식이 부족하다면 이전 포스팅을 참조하는 것이 도움이 될 수 있습니다.",
    date: "2022-04-09",
    file: "ProtocolDeep",
    tags: [.Swift, .iOS],
    thumb: "/images/swiftlogo.png"),
    
    IndexpostInfo(title: "Protocol 이란?",
    context: "이번 포스팅에서는 Swift의 Protocol에 대해서 정리해보려 합니다. 먼저 여기서 다루는 내용은 VIPER 아키텍처를 공부하다 생긴 protocol에 대한 궁금증을 해결하는데 집중되어 있음을 알립니다. 따라서 이론적인 부분이나 개념은 깊게 다루지 않을 수도 있습니다. Swift Docs에서는 procotol을 아래와 같이 정의합니다.",
    date: "2022-04-02",
    file: "Protocol",
    tags: [.Swift, .iOS],
    thumb: "/images/swiftlogo.png"),
    
    IndexpostInfo(title: "Vapor로 블로그를 만들어본 후기",
    context: "Vapor는 Swift로 작성된 오픈 소스 웹 프레임 워크입니다. Vapor 깃허브의 생각보다 많은 스타수를 보니 이쪽 세계에선 꽤 유명한 프레임 워크인 것 같더라고요, Discord 커뮤니티도 활성화가 잘 되어있고, 문서도 정리가 잘 되어있어 시작하는데 크게 어려움이 없었습니다.",
    date: "2022-03-25",
    file: "Vapor",
    tags: [.Swift, .Vapor],
    thumb: "/images/vapor-1.png"),

    IndexpostInfo(title: "Strong, Weak, Unowned 참조 키워드",
    context: "이 세가지 키워드는 모두 참조에 관한 키워드입니다. Strong, Weak는 단어만 봤을 땐 뭔가 강하고 약한 것을 의미하는 것 같은데요, Unowned는 어떤 의미인지 감이 잘 안잡히기도 합니다. 이번에는 세 키워드가 하는 역할과 차이에 대해 알아보려 합니다.",
    date: "2022-03-19",
    file: "Strong",
    tags: [.Swift, .iOS],
    thumb: "/images/strongImage.png")
]
