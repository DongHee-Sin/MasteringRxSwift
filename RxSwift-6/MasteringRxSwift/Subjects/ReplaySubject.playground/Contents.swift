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
 # ReplaySubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}


/// Publish, Behavior과 다르게 create메서드를 통해 생성
/// 몇개의 이벤트를 저장하고 사용할지 매개변수로 전달(bufferSize)
let replay = ReplaySubject<Int>.create(bufferSize: 3)


// 10개의 next이벤트 전달
(1...10).forEach { replay.onNext($0) }


/// Observer등록 (buffer에 저장된 이벤트들만 바로 방출)
replay.subscribe { print("Observer1 : \($0)") }
    .disposed(by: disposeBag)

replay.subscribe { print("Observer2 : \($0)") }
    .disposed(by: disposeBag)


/// 새로운 next 이벤트를 전달받으면 가장 오래된 이벤트를 삭제
replay.onNext(11)



replay.subscribe { print("Observer3 : \($0)") }
    .disposed(by: disposeBag)


/// buffer는 결국 메모리에 저장되어 사용되기 때문에, 꼭 필요한 경우가 아니라면 너무 큰 buffer를 갖지 않도록 해야한다.


/// complete, error가 발생해도 새로운 구독이 발생하면 buffer에 저장해둔 이벤트를 방출하고 completed 또는 error 이벤트를 방출한다.

//replay.onCompleted()
replay.onError(MyError.error)


replay.subscribe { print("Observer3 : \($0)") }
    .disposed(by: disposeBag)
