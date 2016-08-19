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
                let fulfilledFuture: Future<String, NoError> = Future(.Success("test"))

                let error = NSError(domain: "test", code: 0, userInfo: nil)
                let rejectedFuture: Future<Any, NSError> = Future(.Failure(error))

                let pendingFuture: Future<String, NoError> = Future()

                describe("value") {
                    context("when the future is fufilled") {
                        it("should return the value") {
                            expect(fulfilledFuture.value).to(beTruthy())
                        }
                    }

                    context("when the future is rejected") {
                        it("should return nil") {
                            expect(rejectedFuture.value).to(beNil())
                        }
                    }

                    context("when the future is pending") {
                        it("should return nil") {
                            expect(pendingFuture.value).to(beNil())
                        }
                    }
                }

                describe("error") {
                    context("when the future is fufilled") {
                        it("should return nil") {
                            expect(fulfilledFuture.error).to(beNil())
                        }
                    }

                    context("when the future is rejected") {
                        it("should return the error") {
                            expect(rejectedFuture.error).to(beTruthy())
                        }
                    }

                    context("when the future is pending") {
                        it("should return nil") {
                            expect(pendingFuture.error).to(beNil())
                        }
                    }
                }

                describe("isFulfilled") {
                    context("when the future is fulfilled") {
                        it("should return true") {
                            expect(fulfilledFuture.isFulfilled).to(beTrue())
                        }
                    }

                    context("when the future is rejected") {
                        it("should return false") {
                            expect(rejectedFuture.isFulfilled).to(beFalse())
                        }
                    }

                    context("when the future is pending") {
                        it("should return true") {
                            expect(pendingFuture.isFulfilled).to(beFalse())
                        }
                    }
                }

                describe("isRejected") {
                    context("when the future is fulfilled") {
                        it("should return true") {
                            expect(fulfilledFuture.isRejected).to(beFalse())
                        }
                    }

                    context("when the future is rejected") {
                        it("should return false") {
                            expect(rejectedFuture.isRejected).to(beTrue())
                        }
                    }

                    context("when the future is pending") {
                        it("should return true") {
                            expect(pendingFuture.isRejected).to(beFalse())
                        }
                    }
                }

                describe("isPending") {
                    context("when the future has not been completed yet") {
                        it("should return true") {
                            expect(pendingFuture.isPending).to(beTrue())
                        }
                    }

                    context("when the future has been completed") {
                        it("should return false ") {
                            expect(fulfilledFuture.isPending).to(beFalse())
                        }
                    }
                }
            }
        }
    }
}
