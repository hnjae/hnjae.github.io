---
tags:
- programming
- JavaScript
title: JavaScript - String Concatenation
categories:
date: 2023-11-04
lastMod: 2023-11-04
---
보고 있는 책의 예시문에서, `Array.prototype.join()` 을 쓰지 않고, `+=` 을 하면서 새 문자열을 만드는 것을 보았다.

예를 들어

```javascript
const array = [];
 for (const char of text) {
   array.push(char);
}
return array.join('');
```

와 같이 `.join()` 를 사용하지 않고, 아래와 같이 처리했다 

```javascript
let result = "";
for (const char of text) {
    result += char;
}
return result;
```

이유를 찾고자 2011년도에 작성된 Stackoverflow 의 글을 읽으니, 현대 자바스크립트 엔진은 `+=` 를 내부에서 최적화해 이것이 더 효율적이라고 한다.

그래서 [DevelAx 님이 만든 테스트 코드 ](https://forum.freecodecamp.org/t/which-is-more-efficient-str-some-string-or-array-push-join/5802/3)를 가지고 직접 테스트 해보았다.

다음과 같은 결과가 나왔다.
|  | Node | Bun | Firefox |
| version | 18.18.2 | 1.0.7 | 119.0 |
| 결과 | `Array.prototype.join()` 승 | `+=` 승 | 결과가 매번 다름 |

### 결론

구현체의 따라 결과가 다르니 기본적으로 `.join()`을 사용하되, concat 할 양이 적다면 `+=` 의 사용을 고려해도 될 것 같다.

### 읽어본 자료
* https://forum.freecodecamp.org/t/which-is-more-efficient-str-some-string-or-array-push-join/5802/3
* https://stackoverflow.com/questions/7299010/why-is-string-concatenation-faster-than-array-join?rq=3
* <https://stackoverflow.com/questions/7296594/array-join-vs-string-concat>
