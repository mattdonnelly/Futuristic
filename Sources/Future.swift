//
//  Futuristic.swift
//  Futuristic
//
//  Created by Matt Donnelly on 17/08/2016.
//
//

import Foundation
import Result

public class Future<T, E: ErrorType> {

    public typealias CompletionCallback = Result<T, E> -> Void
    public typealias SuccessCallback = T -> Void
    public typealias FailureCallback = E -> Void
    public typealias FutureResult = Result<T, E>

    public var result: FutureResult?
    private var completionHandlers: [CompletionCallback] = []

    public init() {}

    public init(queue: dispatch_queue_t, task: () -> FutureResult) {
        dispatch_async(queue) {
            self.complete(task())
        }
    }

    public convenience init(_ result: FutureResult) {
        self.init()
        self.complete(result)
    }

    public convenience init(_ task: () -> FutureResult) {
        let attribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_UTILITY, 0)
        let queue = dispatch_queue_create("com.mattdonnelly.Futuristic", attribute)
        self.init(queue: queue, task: task)
    }

    public var value: T? {
        return self.result?.value
    }

    public var error: E? {
        return self.result?.error
    }

    public var isPending: Bool {
        return self.result == nil
    }

    public var isFulfilled: Bool {
        guard !self.isPending else { return false }
        return self.value != nil
    }

    public var isRejected: Bool {
        guard !self.isPending else { return false }
        return self.error != nil
    }

    public func onComplete(callback: CompletionCallback) -> Future {
        if let result = self.result {
            callback(result)
        } else {
            self.completionHandlers.append(callback)
        }

        return self
    }

    public func onSuccess(callback: SuccessCallback) -> Future {
        return self.onComplete {
            guard let value = $0.value else { return }
            callback(value)
        }
    }

    public func onFailure(callback: FailureCallback) -> Future {
        return self.onComplete {
            guard let error = $0.error else { return }
            callback(error)
        }
    }

    public func complete(result: FutureResult) {
        self.result = result
        self.completionHandlers.forEach { handler in
            handler(result)
        }
    }

    public func fulfill(value: T) {
        self.complete(.Success(value))
    }

    public func reject(err: E) {
        self.complete(.Failure(err))
    }
}