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
import RxCocoa

/*:
 # Relay
 */

let bag = DisposeBag()


/// Relay는 3가지 종류가 있다. => PublishRelay,BehaviorRelay, ReplayRelay
/// Relay는 Subject를 래핑한 형태로 구현되어 있으며, Subject와 마찬가지로 이벤트를 전달받아서 자신을 구독하고 있는 Observer에게 방출하는 기능을 한다.
/// 차이점은 completed, error에 대한 이벤트를 전달받지도 않고, Observer로 전달하지도 않는 것.
/// 자신을 구독하고 있는 Observer가 Dispose되기 전까지 next이벤트를 무한히 방출한다.
/// 이러한 특징 때문에 주로 UI 이벤트에 활용된다. (UIButton의 Tap 이벤트, TextView의 Input 이벤트 등..) => RxCocoa



let publishRelay = PublishRelay<Int>()

publishRelay.subscribe { print("publish : \($0)") }
    .disposed(by: bag)

publishRelay.accept(1)



let behaviorRelay = BehaviorRelay<Int>(value: 10)
behaviorRelay.accept(20)

behaviorRelay.subscribe { print("behavior : \($0)") }
    .disposed(by: bag)

behaviorRelay.accept(30)

print(behaviorRelay.value)  // BehaviorRelay가 가지고 있는 next이벤트의 value를 가져올 수 있다. (Read only)



let replayRelay = ReplayRelay<Int>.create(bufferSize: 3)

(1...10).forEach {
    replayRelay.accept($0)
}

replayRelay.subscribe { print("replay : \($0)") }
    .disposed(by: bag)
