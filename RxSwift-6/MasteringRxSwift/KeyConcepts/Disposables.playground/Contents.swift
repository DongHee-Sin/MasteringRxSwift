//
//  Mastering RxSwift
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


import UIKit
import RxSwift

/*:
 # Disposables
 */

/// Observable에서 Error 또는 Completed 이벤트가 호출되면 모든 리소스가 종료된다.
/// Disposed는 모든 리소스가 정리된 후, 호출된다.
/// Disposed는 Observable이 전달하는 이벤트가 아님
/// #1 코드의 onDisposed 매개변수로 전달한 클로저 구문은 단순히 리소스가 정리된 후, 자동으로 호출되는 것.

// #1
Observable.from([1, 2, 3])
    .subscribe { elem in
        print("Next : \(elem)")
    } onError: { error in
        print("Error : \(error.localizedDescription)")
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }

print("\n-----------------\n")

// #2
Observable.from([1, 2, 3])
    .subscribe {
        print($0)
    }



/// Observable이 Completed 또는 Error 이벤트로 종료되면 리소스 정리를 직접하지 않아도 큰 문제는 없음
/// 하지만 RxSwift 공식문서에서는 위와같은 경우라도 직접 리소스를 정리하라고 명시되어있음.
/// Disposable은 리소스정리에 사용되는 객체

/// subscribe 메서드는 Disposable을 반환한다.
/// 여기서 반환되는 Disposable을 Subscription Disposable이라고도 부른다.
/// 이 Disposable은 "1.리소스 해제"와 "2.실행취소"에 사용된다.



print("\n-----------------\n")


/// 1. Disposable을 사용한 리소스 해제

let subscription1 = Observable.from([1, 2, 3])
    .subscribe { elem in
        print("Next : \(elem)")
    } onError: { error in
        print("Error : \(error.localizedDescription)")
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }

/// 리소스를 해제하는 방법
/// -> RxSwift 공식문서에서는 disposeBag의 사용을 권장


// 1. 반환된 Subscription Disposable에서 dispose()메서드 호출
subscription1.dispose()


// 2. disposeBag을 사용
var bag = DisposeBag()

Observable.from([1, 2, 3])
    .subscribe {
        print($0)
    }
    .disposed(by: bag)
// Subscription Disposable의 disposed(by:)메서드에 미리 선언해둔 disposeBag을 매개변수로 넣으면
// subscribe가 반환하는 Subscription Disposable이 disposeBag에 추가된다.
// disposeBag이 해제되는 시점에 Bag에 추가되어 있던 Disposable도 모두 리소스 해제된다. (Objc의 AutoReleasePool과 비슷한 개념)


// 특정 원하는 시점에 bag에 있는 모든 Disposable들을 리소스 해제하고 싶다면
// 새로운 DisposeBag 인스턴스를 할당하면 된다. (또는 Optional설정 후, nil 할당)
bag = DisposeBag()



print("\n-----------------\n")


/// 2. Disposable을 사용한 실행취소

let subscription2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe { elem in
        print("Next : \(elem)")
    } onError: { error in
        print("Error : \(error.localizedDescription)")
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    // 3초 뒤에 dispose()가 호출되면서 리소스가 정리된다.
    // dispose()를 직접 호출하면 completed는 방출되지 않는다.
    // 때문에 dispose()를 직접 호출하여 리소스를 정리하는 것은 지양해야 한다.
    subscription2.dispose()
}
