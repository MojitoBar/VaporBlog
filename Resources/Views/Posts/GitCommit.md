---
date: 2022년 07월 23일 20:37
description: Git - Commit
oneline: Git이 내부적으로 어떻게 작동하는가. 근데 이제 Commit을 곁들인
tags: Git
thumbnail: /images/git.png
contents: 서론/
file: Protocol
---

## 서론

어쩌다 저쩌다 기회가 되서 버전 관리 시스템인 ~~Git~~이 내부적으로 어떻게 동작하는지와 그 중 ~~Commit~~이 어떠한 역할을 하는지 디테일하게 알아보게 되었습니다.

## 깃의 내부 동작 원리
    
쉽게 말해 로컬 저장소의 변경사항을 기록하는 명령어 입니다. 

저는 처음 깃을 사용할 떄는 **add**와 **commit**의 차이점을 명확히 알지는 못했는데요,
    
add 와의 차이점은 변경 사항을 ~~stage area~~에 저장하는 키워드가 add라면, commit은 이를 바탕으로 새로운 버전을 생성하는 키워드입니다.

아래의 사진과 함께 보면 더욱 이해하기 쉽습니다. [출처](https://it-eldorado.tistory.com/4)

<img alt="insidegit" src="/images/insidegit.png"/>
    
그림에 있는 **키워드**들을 잠깐 살펴보자면,

~~Index~~: 개념적으로는 커밋이 이뤄질 준비가 된 파일의 내용들이 위치하는 영역을 의미하며, 실제로는 하나의 파일로서 존재합니다.

~~Repository(.git/objects/)~~: 깃이 버전 관리를 하기 위해 필요로 하는 데이터들을 저장하는 곳입니다.  

~~Blob 파일~~: 버전 관리하는 파일들 각각의 깃의 저장소에서 Blob 파일의 행태로 저장됩니다. 파일의 내용에 SHA1이라는 해싱 기법을 적용하여 Blob 파일의 이름을 얻어내기 때문에, **내용이 같은 파일들은 모두 하나의 Blob 파일로서 저장됩니다.** 이러한 원리로 깃은 여러 버전에 걸쳐 존재하는 파일들의 내용을 중복 없이 관리할 수 있게 됩낟.

~~Commit 파일~~: 하나의 버전을 생성한다는 것은 하나의 Commit 파일을 만드는 것을 의미합니다. Commit 파일은 하나의 Tree 파일을 가리키게 되어 있습니다. 이 파일에는 **가리키고 있는 Tree 파일의 주소와 직전 버전에 해당하는 Commit 파일의 주소가 기록**됩니다.

~~Tree 파일~~: 커밋 시점의 파일들 각각에 대해 그 파일명과 해당 파일의 내용을 담고 있는 Blob 파일의 주소가 기록됩니다. 

즉, add를 하게되면 로컬의 변경사항을 인덱스에 반영하게 되고, commit을 하게되면 index에 저장된 변경사항을 하나의 버전으로 저장하게 되는 것입니다.


## Commit의 옵션들

공식문서를 보면 Commit만 해도 정말 많은 옵션들이 있는데요 그 중 자주쓰는 옵션이나 기본적인 것들에 대해 정리해봤습니다.

**-a / —all**

수정 및 삭제된 파일을 자동으로 준비하도록 명령에 지시하지만 Git에 알리지 않은 새 파일은 영향을 받지 않습니다.

해당 옵션을 사용하면 사진과 같은 vim 창이 뜨고 아래 커밋 메시지와 함께 저장하면 커밋이 완료됩니다.
        
![스크린샷 2022-07-22 오후 2.49.08.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1aa37d7e-c4e4-402e-9d41-8132261f598e/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-07-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.49.08.png)
        
**-p / -patch**

대화형 패치 선택 인터페이스를 사용하여 커밋할 변경 사항을 선택합니다. 자세한 내용은 [git-add](https://git-scm.com/docs/git-add)를 참조하세요.

**-C commit / —reuse-message=commit **

기존 커밋 객체를 가져와 커밋 생성 시 로그 메시지와 저자 정보(타임스탬프 포함)를 재사용합니다.

commit 에는 아래 사진에 보이는 ~~2f70cec~~ 와 같은 commit 객체를 붙여넣으면 됩니다.
    
![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a95e286d-642d-443a-8ff0-b84fdb25e011/Untitled.png)
    
**-c <commit> / —reedit-message=<commit>**

C와 유사하지만 -c를 사용하면 편집기가 호출되므로 사용자가 커밋 메시지를 추가로 편집할 수 있습니다.

**—fixup=[(amend|reword):]<commit>**

 rebase를 위한 목적지 커밋을 지정할 때 사용. [자세한 설명 링크](https://enghqii.tistory.com/54)
 
 amend와 reword는 선택 사항이고 commit은 마찬가지로 commit 객체를 사용
 
 이렇게 커밋하면 아래 사진과 같이 앞에 “fixup!”이라고 메시지가 추가됨.
 
 amend와 reword는 fixup 대신 amend와 reword로
    
![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4b23a952-9873-4a52-8511-980dc5ed594a/Untitled.png)
    
**—squash=<commit>**

rebase --autosquash와 함께 사용할 커밋 메시지를 구성합니다. 커밋 메시지 제목 줄은 "squash!" 접두사가 있는 지정된 커밋에서 가져옵니다. 추가 커밋 메시지 옵션(-m/-c/-C/-F)과 함께 사용할 수 있습니다. 자세한 내용은 [git-rebase](https://git-scm.com/docs/git-rebase)를 참조하세요.

해당 명령어를 단독으로 사용하지는 않는 것 같고 rebase를 할 때 필요한 명령어로 보인다. [자세한 설명 링크](https://meetup.toast.com/posts/39)

**-m <msg> / —message=<msg>**

주어진 <msg>를 커밋 메시지로 사용하십시오. 여러 -m 옵션이 제공되면 해당 값은 별도의 단락으로 연결됩니다.

메시지와 함께 커밋할때 사용하며, `-c`, `-C,` `-F`와 함께 사용할 수 없다.

**-F <file> / —file=<file>**

주어진 파일에서 커밋 메시지를 가져옵니다. -를 사용하여 표준 입력에서 메시지를 읽습니다.

실행 해보니 파일 내용을 그대로 가져오는 듯하다. 예를 들어 git commit -F [README.md](http://README.md) 로 커밋을 남기면 파일 내용이 그대로 커밋 메시지에 남는다.

## 참고자료
