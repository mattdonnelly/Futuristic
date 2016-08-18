//
//  FutureTests.swift
//  Futuristic Tests
//
//  Created by Matt Donnelly on 17/08/2016.
//
//

import Quick
import Nimble
import Futuristic
import Result

class FutureTests: QuickSpec {
    override func spec() {
        describe("Future") {
            describe("properties") {
                let fulfilledFuture: Future<String, NSError> = Future(.Success("test"))

                let error = NSError(domain: "test", code: 0, userInfo: nil)
                let rejectedFuture: Future<String, NSError> = Future(.Failure(error))

                let pendingFuture: Future<String, NSError> = Future()

                describe("getters") {
                    describe("value") {
                        it("should return the value for fulfilled future") {
                            expect(fulfilledFuture.value).to(beTruthy())
                        }

                        it("should return nil for a rejected future") {
                            expect(rejectedFuture.value).to(beNil())
                        }

                        it("should return nil for a pending future") {
                            expect(pendingFuture.value).to(beNil())
                        }
                    }

                    describe("error") {
                        it("should return nil for fulfilled future") {
                            expect(fulfilledFuture.error).to(beNil())
                        }

                        it("should return the error for a rejected future") {
                            expect(rejectedFuture.error).to(beTruthy())
                        }

                        it("should return nil for a pending future") {
                            expect(pendingFuture.error).to(beNil())
                        }
                    }
                }

                describe("status checks") {
                    describe("isFulfilled") {
                        it("should return true when the future has been fulfilled") {
                            expect(fulfilledFuture.isFulfilled).to(beTrue())
                        }

                        it("should return false when the future has been rejected") {
                            expect(rejectedFuture.isFulfilled).to(beFalse())
                        }

                        it("should return true when the future has not been completed") {
                            expect(pendingFuture.isFulfilled).to(beFalse())
                        }
                    }

                    describe("isRejected") {
                        it("should return false when the future has been fulfilled") {
                            expect(fulfilledFuture.isRejected).to(beFalse())
                        }

                        it("should return true when the future has been rejected") {
                            expect(rejectedFuture.isRejected).to(beTrue())
                        }

                        it("should return true when the future has not been completed") {
                            expect(pendingFuture.isRejected).to(beFalse())
                        }
                    }
                    
                    describe("isPending") {
                        it("should return true when the future has not been completed") {
                            expect(pendingFuture.isPending).to(beTrue())
                        }
                        
                        it("should return false when the future has been completed") {
                            expect(fulfilledFuture.isPending).to(beFalse())
                        }
                    }
                }
            }
        }
    }
}
