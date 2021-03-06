---
date: 2022년 04월 24일 23:07
description: iOS 어플 Gifty 배포 회고
oneline: 아이폰 갤러리에서 기프티콘만 찾아주는 어플이 있다??
tags: iOS, Swift
thumbnail: /images/gifty.png
contents: Gifty!/만들게 된 계기/개발 과정/너무 오래 걸리는 로딩/원하지 않는 바코드 사진/테스트 플라이트 심사/앱 스토어 등록 과정/후기
file: Gifty
---

## Gifty!

이번 포스팅에서는 처음으로 배포하게 된 Gifty 어플에 대한 회고를 작성해보려 합니다.

회고를 작성하기 전에 이번에 배포하게 된 ~~Gifty~~에 대해서 간단히 소개를 하려 합니다!

<img alt="gifty" src="/images/gifty.png" style="display: block; margin: auto; width: 200px;"/>

~~Gifty~~는 Apple의 ~~Vision 프레임워크~~를 주력으로 사용하여 갤러리에 있는 기프티콘 이미지만 뽑아 보여주는 어플입니다.

현재는 [앱스토어](https://apps.apple.com/kr/app/gifty/id1592949834)에서 다운 받을 수 있습니다 ㅎㅎ

## 만들게 된 계기

저 같은 경우에는 기프티콘을 **사진**으로 받는 경우가 꽤 있었는데, 보통 갤러리에 저장해놓고 까먹는 경우가 종종 있었습니다.

사진으로 받는 기프티콘의 경우에는 유효기간을 늘리기에도 쉽지가 않아서 따로 **보관**할 수 있으면 좋겠다라는 생각을 했었는데요,

마침 교내 **IT 경진대회**가 있다는 소식을 듣고 이참에 한번 만들어 봐야겠다! 하는 생각이 들었습니다.

## 개발 과정

사진 앱에서 사진을 불러오는 기능같은 경우는 쉽게 구현할 수 있었는데, 문제는 **바코드** 이미지를 식별하는 부분이었습니다.

처음에는 기프티콘 이미지가 정형화 되어있다는 점을 이용해 이미지를 **기계학습**을 시켜 분류하려고 했었습니다.

하지만 관련 지식이 너무 없었기도 했고, 기프티콘사진 vs 나머지 사진 으로 분류하는 것이 생각보다 [어려운 기술](https://en.wikipedia.org/wiki/One-class_classification)이라는 것을 알게 되었습니다.

<img alt="vision" src="/images/vision.png" style="display: block; margin: auto; width: 300px;"/>

따라서 새롭게 찾은 방법이 바로 Apple의 [Vision 프레임워크](https://developer.apple.com/kr/machine-learning/api/)였습니다.

그 중에서 [VNDetectBarcodesRequest](https://developer.apple.com/documentation/vision/vndetectbarcodesrequest)라는 바코드 감지 클래스를 활용하였습니다.

개발하며 여러 이슈들이 있었지만 그 중 기억에 남는 것들을 정리해 보았습니다.

## 너무 오래 걸리는 로딩

저는 사진을 많이 찍는 편이 아니라 갤러리에 사진이 약 2000장 정도 있는데요, 사진 찍는 걸 좋아하는 친구의 경우나 휴대폰을 오래 쓴 경우엔 **8000장**도 우습다는 것을 알게 되었습니다.

당연히 2000장 기준으로 개발했으니 사진이 훨씬 많다면, 모든 사진을 스캔하는 시간이 너무 오래걸리게 됐습니다.

저는 이 문제를 해결하기 위해 **Serial**이 아닌 ~~Concurrent Queue~~을 사용했습니다.

총 사진의 양을 3분할로 불러오게 수정해 기존에 3분 정도 걸리던 시간이 약 1분 정도로 줄어들었습니다.

<img alt="concurrentqueue" src="/images/concurrentqueue.png"/>

시간이 많이 줄어들었지만 3만장에 10분은 여전히 긴 시간이었습니다.

그래서 저는 이를 더 많은 쓰레드로 속도를 줄이기 보단 최신순으로 몇 장의 사진을 검사할 지 선택할 수 있는 기능을 추가했습니다.

덕분에 갤러리의 모든 사진을 검사하지 않아도 됐고, 어느정도 이슈를 해결할 수 있었습니다.

## 원하지 않는 바코드 사진

갤러리에서 사진을 뽑아와 이미지를 스캔할 때 기프티콘만 뽑아오는 것을 기대했었습니다.

하지만 바코드가 포함된 이미지면 모두 필터 돼 원하지 않는 **다른 상품(과자 봉지, 영수증 등)**이 포함되는 이슈가 있었습니다.

이 문제를 해결하기 위해선 바코드에 대한 사전 지식이 필요했습니다.

우리가 일반적으로 구매하는 물품에 표시된 바코드는 ~~EAN13(국제 상품 번호)~~ 규격을 따르고 있었고,

기프티콘이나 상품권 등에 쓰이는 바코드는 ~~Code128 규격~~을 따르고 있다는 것을 알게 되었습니다.

이 점을 이용해 기존의 ~~VNBarcodeSymbology~~가 검사하던 바코드 종류를 **Code128**로 명시해 어느정도 문제를 해결했습니다.

이 외에도 스캔 중 로딩 애니메이션이나 처리 현황을 퍼센트로 보여주는 텍스트 등이 필요했기 때문에 ~~GCD~~의 개념과 ~~동기 & 비동기 프로그래밍~~에 대해 정확하게 알아야만 했습니다.

## 테스트 플라이트 심사

교내 ~~IT 경진대회~~에 나가게 되면 부스를 만들어 교수님과 학생들을 대상으로 **전시**를 하게 되는데요,

이때 Gifty 어플이 의미가 있으려면 부스에 찾아오시는 분들이 ~~Gifty~~를 직접 실행해볼 수 있어야 한다고 생각했습니다.

하지만 시간은 촉박했고, 한번도 앱스토어에 등록을 해본적이 없었던지라 상대적으로 쉬운 테스트 플라이트 **외부 테스팅**으로 만족해야만 했습니다.

<img alt="appstoregifty" src="/images/appstoregifty.png"/>
 
한 가지 새로웠던 점은 ~~테스트 플라이트~~로 배포할 때 내부 테스팅의 경우 별도의 심사없이 테스트를 해볼 수 있지만, **외부 테스팅**의 경우엔 Apple의 심사를 통과해야한다는 점이었습니다.

실제로 **Gifty**는 기프티콘 사진이 없다면 사진 앱에서 이미지를 검사해도 **CollectionView**에는 아무것도 안뜨게 되는데, 이 부분에서 **Gifty**가 뭐하는 어플인지 모르겠다는 피드백과 함께 리젝당한 경험이 있습니다. (부가적인 설명과 직관적인 UI로 수정하여 통과하긴 했습니다...)

## 앱 스토어 등록 과정

앱 스토어 등록은 제 어플이 간단하기도 했고, 이미 테스트 플라이트를 통해 몇 번 심사를 받았던지라 별 문제 없이 통과 할 수 있었습니다.

앞서 배포를 진행한 개발자 분들께서 자세히 정리한 블로그를 참고하니 크게 어려운 점은 없었습니다.

몇 가지 팁이 될만한 **사이트 링크**를 아래 남겨 드리도록 하겠습니다! 

## 후기

처음 배포가 되고 **AppStore**에서 ~~Gifty~~를 검색해서 직접 다운로드 받아봤을 땐 기분이 되게 묘했습니다.

이런 식으로 다들 배포했던거구나... 하는 생각도 들고 한 번 해보니 두 번은 더 쉬울 것 같아 빨리 다음으로 배포할 어플도 만들고 싶어졌습니다.

현재 ~~Gifty~~는 어플을 껏다 켯을 때 사진 저장이 안된다는 점이 있는데, 이 부분만 추가해서 올리면 개인적으로 매우 만족스러운 프로젝트가 될 것이라 생각합니다.

## 참고자료
<ul>
<li>
    <a href="https://velog.io/@minji0801/%EC%95%B1%EC%8A%A4%ED%86%A0%EC%96%B4%EC%97%90-%EC%95%B1-%EB%93%B1%EB%A1%9D%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95%EC%9D%84-%EB%AA%A8%EB%A5%B4%EA%B2%A0%EB%8B%A4">App Store 배포하는 법</a>
</li>
<li>
    <a href="https://app-mockup.com/">앱 스토어 스크린샷 템플릿 사이트</a>
</li>
<li>
    <a href="https://blog.naver.com/PostView.nhn?isHttpsRedirect=true&blogId=taerg89&logNo=221597544190">개인정보처리방침 만들기</a>
</li>
</ul>
