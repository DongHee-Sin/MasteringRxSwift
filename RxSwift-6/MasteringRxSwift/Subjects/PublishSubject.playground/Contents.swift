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
 # PublishSubject
 */
/// Subject로 전달되는 이벤트를 Observer에 그대로 전달하는 가장 기본적인 Subject

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}


/// 제네릭으로 String Type을 입력하면, String을 방출하는 Next이벤트를 받아서 Observer로 전달할 수 있다.
/// PublishSubject는 생성자 메서드로 아무것도 받지 않음. == Subject 객체 내부에는 어떠한 이벤트도 가지고 있지 않음.
/// 때문에 Subject 생성 직후에 Observer가 Subject를 구독해도 아무런 이벤트도 전달되지 않음.

let subject = PublishSubject<String>()

subject.onNext("HELLO")  // subject에게 onNext이벤트 전달

let observer1 = subject.subscribe { print("Observer1 => \($0)") }
observer1.disposed(by: disposeBag)

subject.onNext("HI")


let observer2 = subject.subscribe { print("Observer2 => \($0)") }
observer2.disposed(by: disposeBag)

subject.onNext("RxSwift")


//subject.onCompleted()     // subject에게 Completed이벤트 전달
subject.onError(MyError.error)
 
subject.onNext("RXRXRX")    // completed 이후에는 next 이벤트를 전달하지 않음


// Completed된 Subject는 더이상 next이벤트를 전달할 수 없어서 새로운 Observer가 해당 Subject를 구독해도 바로 completed 이벤트가 전달된다.
// Error도 마찬가지로 onError 이벤트를 받고 종료된 Subject는 새로운 구독자가 나타나도 error이벤트를 바로 전달하며 next이벤트를 방출할 수 없다.
let Observer3 = subject.subscribe { print("Observer3 => \($0)") }
Observer3.disposed(by: disposeBag)


/// PublishSubject는 이벤트를 전달받는 즉시 Observer로 전달하며 이벤트를 따로 저장해두지 않는다.
/// 때문에, Subject 객체가 생성되는 시점 ~ 첫 구독이 발생하는 시점 사이에 전달받는 next이벤트는 사라진다.
