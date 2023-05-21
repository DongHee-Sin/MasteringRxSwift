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
 # of
 */

// Of (ObservableSequence)

//final private class ObservableSequence<Sequence: Swift.Sequence>: Producer<Sequence.Element> {
//    fileprivate let elements: Sequence
//    fileprivate let scheduler: ImmediateSchedulerType
//
//    init(elements: Sequence, scheduler: ImmediateSchedulerType) {
//        self.elements = elements
//        self.scheduler = scheduler
//    }
//
//    override func run<Observer: ObserverType>(_ observer: Observer, cancel: Cancelable) -> (sink: Disposable, subscription: Disposable) where Observer.Element == Element {
//        let sink = ObservableSequenceSink(parent: self, observer: observer, cancel: cancel)
//        let subscription = sink.run()
//        return (sink: sink, subscription: subscription)
//    }
//}


let disposeBag = DisposeBag()
let apple = "🍏"
let orange = "🍊"
let kiwi = "🥝"


/// 가변 매개변수를 전달받아서 각 Element를 next이벤트로 방출한 후, completed
/// n개의 Element를 next로 방출하는 목적으로 사용


Observable.of(apple, orange, kiwi)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

//next(🍏)
//next(🍊)
//next(🥝)
//completed



Observable.of([1, 2], [3, 4], [5, 6])
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

//next([1, 2])
//next([3, 4])
//next([5, 6])
//completed
