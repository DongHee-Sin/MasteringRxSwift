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
 # BehaviorSubject
 */
/// PublishSubject와 동일하게 전달받은 이벤트를 Observer에게 그대로 전달
/// 차이점은 생성 시점에 있다.

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}


/// Publish는 생성 시점에 이벤트가 저장되어 있지 않아서, 인스턴스 생성 후 구독이 발생해도 이벤트가 전달되지 않음
let publish = PublishSubject<Int>()

publish.subscribe { print("PublishSubject : \($0)") }
    .disposed(by: disposeBag)



/// Behavior는 생성자 메서드에서 value를 받음
/// 생성 시점에 내부적으로 next이벤트가 하나 저장되는데, 해당 이벤트의 value가 매개변수로 전달받은 값이 된다.
/// 생성된 next이벤트는 구독이 발생하는 시점에 방출된다.
let behavior = BehaviorSubject<Int>(value: 0)

behavior.subscribe { print("Behavior1 : \($0)") }
    .disposed(by: disposeBag)

/// Behavior로 새로운 onNext 이벤트가 전달되면 해당 이벤트의 value로 내부 저장값이 변경된다.
behavior.onNext(1)


/// 새로운 구독이 발생하면 Behavior에 저장되어 있는 가장 최신의 next이벤트가 방출된다.
behavior.subscribe { print("Behavior2 : \($0)") }
    .disposed(by: disposeBag)


//behavior.onCompleted()
behavior.onError(MyError.error)

/// completed 또는 error 이벤트가 전달된 후, 구독이 발생하면 즉시 completed, error 이벤트를 전달하고 종료된다.
behavior.subscribe { print("Behavior3 : \($0)") }
    .disposed(by: disposeBag)
