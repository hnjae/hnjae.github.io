---
tags:
- programming
- JavaScript
title: JavaScript - Function
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
JavaScript 에서 함수를 정의할 때, 함수 선언식(function declarations) 또는 함수 표현식 (function expressions)을 사용할 수 있다. 함수 선언식을 사용하면 함수가 호이스팅되어, 함수 표현식을 사용하는 것을 권장하기도 한다.

#### 예시
예를 들어 다음과 같은 코드를 말한다.

다음은 함수 선언식으로 선언된 함수이다. 함수가 호이스팅되어, 함수를 정의하기 전에 사용이 가능하다.
```javascript
foo();

function foo() {
  console.log("hello");
};
```

다음은 함수 표현식으로 정의 한 함수이다.
```javascript
notHoisted(); // TypeError: notHoisted is not a function

const notHoisted = function () {
  console.log("bar");
};

// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function 에서 발췌 (2023-11-16)
```

### 어떤 방식을 사용해야 하는가

Airbnb 에서는 다음 형식으로 선언하기를 권장하고 있다. [#](https://github.com/airbnb/javascript#functions)

```javascript
// bad
function foo() {
  // ...
}

// bad
const foo = function () {
  // ...
};

// good
// lexical name distinguished from the variable-referenced invocation(s)
const short = function longUniqueMoreDescriptiveLexicalFoo() {
  // ...
};

// git@github.com:airbnb/javascript commit 11ab371 (2023-08-21) 에서 발췌
```

두번째가 아니라, 세번째 방식을 권한 이유는 다음과 같다.

> Don’t forget to explicitly name the expression, regardless of whether
or not the name is inferred from the containing variable (which is often
 the case in modern browsers or when using compilers such as Babel). 
This eliminates any assumptions made about the Error’s call stack.

### 같이보기
* https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function
* https://github.com/airbnb/javascript
* https://eslint.org/docs/latest/rules/func-style
