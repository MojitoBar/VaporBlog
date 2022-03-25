//
//  File.swift
//  
//
//  Created by judongseok on 2022/03/21.
//
let postDatas: [IndexpostInfo] = [
    IndexpostInfo(title: "Vapor로 블로그를 만들어본 후기",
        context: "Vapor는 Swift로 작성된 오픈 소스 웹 프레임 워크입니다. Vapor 깃허브의 생각보다 많은 스타수를 보니 이쪽 세계에선 꽤 유명한 프레임 워크인 것 같더라고요, Discord 커뮤니티도 활성화가 잘 되어있고, 문서도 정리가 잘 되어있어 시작하는데 크게 어려움이 없었습니다.",
        date: "2022-03-25",
        file: "VaporPost1",
        tags: [.Swift, .Vapor],
        thumb: "/images/vapor-1.png"),

    IndexpostInfo(title: "Strong, Weak, Unowned 키워드",
                  context: "이 세가지 키워드는 모두 참조에 관한 키워드입니다. Strong, Weak는 단어만 봤을 땐 뭔가 강하고 약한 것을 의미하는 것 같은데요, Unowned는 어떤 의미인지 감이 잘 안잡히기도 합니다. 이번에는 세 키워드가 하는 역할과 차이에 대해 알아보려 합니다.",
                  date: "2022-03-19",
                  file: "SecondPost",
                  tags: [.Swift, .iOS],
                  thumb: "/images/strongImage.png")
]
