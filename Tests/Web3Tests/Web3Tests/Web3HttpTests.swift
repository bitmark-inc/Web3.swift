//
//  Web3HttpTests.swift
//  Web3_Tests
//
//  Created by Koray Koska on 14.01.18.
//  Copyright © 2018 Boilertalk. All rights reserved.
//

import Quick
import Nimble
@testable import Web3
import BigInt

class Web3HttpTests: QuickSpec {

    let infuraUrl = "https://mainnet.infura.io/v3/362c324f295a4032b2fe87d910aaa33a"

    override func spec() {
        describe("http rpc requests") {

            let web3 = Web3(rpcURL: infuraUrl)

            context("web3 client version") {

                waitUntil(timeout: 2.0) { done in
                    web3.clientVersion { response in
                        it("should be status success") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("net version") {

                waitUntil(timeout: 2.0) { done in
                    web3.net.version { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be mainnet chain id") {
                            expect(response.result) == "1"
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("net peer count") {

                waitUntil(timeout: 2.0) { done in
                    web3.net.peerCount { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a quantity response") {
                            expect(response.result?.quantity).toNot(beNil())
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth protocol version") {

                waitUntil(timeout: 2.0) { done in
                    web3.eth.protocolVersion { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth syncing") {

                waitUntil(timeout: 2.0) { done in
                    web3.eth.syncing { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a valid response") {
                            expect(response.result?.syncing).toNot(beNil())

                            if let b = response.result?.syncing, b {
                                expect(response.result?.startingBlock).toNot(beNil())
                                expect(response.result?.currentBlock).toNot(beNil())
                                expect(response.result?.highestBlock).toNot(beNil())
                            } else {
                                expect(response.result?.startingBlock).to(beNil())
                                expect(response.result?.currentBlock).to(beNil())
                                expect(response.result?.highestBlock).to(beNil())
                            }
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth mining") {

                waitUntil(timeout: 2.0) { done in
                    web3.eth.mining { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a bool response") {
                            // Infura won't mine at any time or something's gonna be wrong...
                            expect(response.result) == false
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth hashrate") {

                waitUntil(timeout: 2.0) { done in
                    web3.eth.hashrate { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a quantity response") {
                            // Infura won't mine at any time or something's gonna be wrong...
                            expect(response.result?.quantity) == 0
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth gas price") {

                waitUntil(timeout: 2.0) { done in
                    web3.eth.gasPrice { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a quantity response") {
                            // Infura won't mine at any time or something's gonna be wrong...
                            expect(response.result?.quantity).toNot(beNil())
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth accounts") {

                waitUntil(timeout: 2.0) { done in
                    web3.eth.accounts { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be an array response") {
                            // Infura should not have any accounts...
                            expect(response.result?.count) == 0
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth block number") {

                waitUntil(timeout: 2.0) { done in
                    web3.eth.blockNumber { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a quantity response") {
                            expect(response.result?.quantity).toNot(beNil())
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth get balance") {

                let e = try? EthereumAddress(hex: "0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8", eip55: false)
                it("should not be nil") {
                    expect(e).toNot(beNil())
                }
                guard let ethereumAddress = e else {
                    return
                }

                waitUntil(timeout: 2.0) { done in
                    web3.eth.getBalance(address: ethereumAddress, block: .block(4000000)) { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a quantity response") {
                            expect(response.result?.quantity) == BigUInt("1ea7ab3de3c2f1dc75", radix: 16)
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth get storage at") {

                let e = try? EthereumAddress(hex: "0x06012c8cf97BEaD5deAe237070F9587f8E7A266d", eip55: false)
                it("should not be nil") {
                    expect(e).toNot(beNil())
                }
                guard let ethereumAddress = e else {
                    return
                }

                waitUntil(timeout: 2.0) { done in
                    web3.eth.getStorageAt(address: ethereumAddress, position: 0, block: .latest) { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a data response") {
                            expect(response.result?.hex()) == "0x000000000000000000000000af1e54b359b0897133f437fc961dd16f20c045e1"
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth get transaction count") {

                let e = try? EthereumAddress(hex: "0x464B0B37db1eE1b5Fbe27300aCFBf172fD5E4F53", eip55: false)
                it("should not be nil") {
                    expect(e).toNot(beNil())
                }
                guard let ethereumAddress = e else {
                    return
                }

                waitUntil(timeout: 2.0) { done in
                    web3.eth.getTransactionCount(address: ethereumAddress, block: .block(4000000)) { response in
                        it("should be status ok") {
                            expect(response.status.isSuccess) == true
                        }
                        it("should not be nil") {
                            expect(response.result).toNot(beNil())
                        }
                        it("should be a quantity response") {
                            expect(response.result?.quantity) == 0xd8
                        }

                        // Tests done
                        done()
                    }
                }
            }

            context("eth get transaction count by hash") {
                waitUntil(timeout: 2.0) { done in
                    do {
                        try web3.eth.getBlockTransactionCountByHash(blockHash: .string("0x596f2d863a893392c55b72b5ba29e9ba67bdaa13c31765f9119e850a62565960")) { response in
                            it("should be status ok") {
                                expect(response.status.isSuccess) == true
                            }
                            it("should not be nil") {
                                expect(response.result).toNot(beNil())
                            }
                            it("should be a quantity response") {
                                expect(response.result?.quantity) == 0xaa
                            }

                            // Tests done
                            done()
                        }
                    } catch {
                        it("should not throw an error") {
                            expect(false) == true
                        }
                        done()
                    }
                }
            }
        }
    }
}
