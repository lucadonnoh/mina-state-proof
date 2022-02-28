// SPDX-License-Identifier: MIT OR Apache-2.0
//---------------------------------------------------------------------------//
// Copyright (c) 2021 Mikhail Komarov <nemo@nil.foundation>
// Copyright (c) 2021 Ilias Khairullin <ilias@nil.foundation>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//---------------------------------------------------------------------------//

pragma solidity >=0.6.0;
pragma experimental ABIEncoderV2;

import "truffle/Assert.sol";
import '../contracts/cryptography/polynomial_adapted.sol';
import '../contracts/field_math.sol';

contract TestFieldMath {
    function test_field_math() public {
        uint256 i = 1;
        Assert.equal(0, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(10, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(11, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(12, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(12, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(13, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(13, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(13, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(13, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(14, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(15, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(16, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
        Assert.equal(17, field_math.log2(i), "Log2 result is not correct");
        i += 1000;
    }
}
