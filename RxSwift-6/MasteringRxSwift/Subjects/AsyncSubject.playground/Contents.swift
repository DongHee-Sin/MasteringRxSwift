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
 # AsyncSubject
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}


/// AsyncSubject는 completed이벤트를 전달받기 전까지 Observer로 이벤트를 전달하지 않음
/// completed를 전달받으면 가장 마지막에 전달받은 next이벤트를 Observer로 방출


let asyncSubject = AsyncSubject<Int>()

asyncSubject
    .subscribe { print($0) }
    .disposed(by: bag)

asyncSubject.onNext(1)
asyncSubject.onNext(2)
asyncSubject.onNext(3)


/// complete를 전달받으면 가장 마지막의 next이벤트를 전달하고 completed이벤트를 전달
//asyncSubject.onCompleted()


/// error를 전달받으면 error이벤트만 Observer로 전달한 후, 종료
asyncSubject.onError(MyError.error)
