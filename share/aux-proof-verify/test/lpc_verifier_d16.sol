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

pragma solidity >=0.8.4;
pragma experimental ABIEncoderV2;

import "truffle/Assert.sol";
import '../contracts/cryptography/types.sol';
import '../contracts/commitments/fri_verifier.sol';
import '../contracts/commitments/lpc_verifier.sol';
import '../contracts/cryptography/transcript.sol';

// TODO: add false-positive tests
contract TestLPCVerifier_d16 {
    function test_lpc_proof_verification_d16() public {
        // bn254 scalar field
        uint256 modulus = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        bytes memory raw_proof = hex"00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000001000000000000000000000000000000000000000000000000000000093c3fd5c4000000000000000300000000000000020d290fcf4d9880f934970cc30d943c97a4bca78fcfa4b59fc4f1dcfffbf5d90d1e89d09fb2cf975e1a93b0f9659074117acd0d049a9a5445cfb3857c4eafa8e100000000000000031096b25766820f869d1063a7e5ab016df4b8a0b8bfa9739d7e9d0705f3c892c000000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000020559201106e80dedf628230cd76d081bf8b42137cf2c9d6bb862f2fbcafd37a31278f47c764d688ed5ea487d2cd262139c57874aa1b1c5406e59ac5ae0597dba0000000000000001000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf860000000000000003000000000000000100000000000000000000000000000020b4de53960b02deaa73a50c20b9bc745da743bdd4d08a40442ee757745df5455700000000000000010000000000000001000000000000002058acfb8892e18e2cfb2b3adcb50bfdcb56903f02ba4bc77b1c970c2a4949ac000000000000000001000000000000000100000000000000201e9cf6673864e7364b2619c142a4e113ea2495907f2dbd7c7a8a878589ead8890000000000000002000000000000000100000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000004000000000000000100000000000000000000000000000020c6bb06cb7f92603de181bf256cd16846b93b752a170ff24824098b31aa008a7e0000000000000001000000000000000100000000000000206926cc6f9563da8fa6836177688ebfd52e3446c2e344d37949a222802a94eee70000000000000001000000000000000100000000000000205194a231165353123cbe4940bdbee3c1e726f8ed8ab5c6f5632d9353a2e8496d00000000000000010000000000000001000000000000002072697671d9683845d813b5b609a51e9e1c398b1ae9e2fecd065680155b0c6550000000000000000900000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000040000000000000001000000000000000000000000000000208a35acfbc15ff81a39ae7d344fd709f28e8600b4aa8c65c6b64bfe7fe36bd19b000000000000000100000000000000010000000000000020f30cd4b26a02d9e7718d60239f2256ee5ed5c5abfb059c08afa921df0b4cb30f0000000000000001000000000000000100000000000000204588fe9e87ee6f31163531890c67d678d24c4494821a1028f0f465520ff379e3000000000000000100000000000000000000000000000020ff58fff29fd22036c585d43655b2a2e930aaccffa097d22c96f45c4f101223c815129f22d89d9f177f2bef167f2bebff6f1f053ea8efce60b2729eb5d6b7fca7000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf8600000000000000021096b25766820f869d1063a7e5ab016df4b8a0b8bfa9739d7e9d0705f3c892c00100e08088a0fc78dae25e6ca97531359118ec3c519327c73b112609da091a9c0000000000000001000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f60000000000000002000000000000000100000000000000000000000000000020bfab4c0cb5f9a42b2b9b7b574606437cb1bc719135a8c82d73b53491df46df920000000000000001000000000000000100000000000000209b5aecf08a63bcecb281eafbd55d2efcc0931766837bb23546064c2732b2918a00000000000000020000000000000001000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf860000000000000003000000000000000100000000000000000000000000000020b4de53960b02deaa73a50c20b9bc745da743bdd4d08a40442ee757745df5455700000000000000010000000000000001000000000000002058acfb8892e18e2cfb2b3adcb50bfdcb56903f02ba4bc77b1c970c2a4949ac000000000000000001000000000000000100000000000000201e9cf6673864e7364b2619c142a4e113ea2495907f2dbd7c7a8a878589ead8890000000000000005000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf860000000000000003000000000000000100000000000000000000000000000020f3d4b9dc2076341e8ad25dffbd467bc8e06cb910966771fd65e0dc2cd64001220000000000000001000000000000000100000000000000208fa8a9e215a9b8a70dde00e8b2b9ee97eb237b0197775eb989a18545b2ea1dd90000000000000001000000000000000000000000000000200f3152c8e1a84e494393fe3413f931112a52cca6b24dea3e3de57518257cf3671f038da27bfa89c4d253a180298520e3522382d3aec3d1eb39204d179d46302d000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f6000000000000000215129f22d89d9f177f2bef167f2bebff6f1f053ea8efce60b2729eb5d6b7fca706bc0a25ec560c40cd3552712f86ba3ab317177ef9e82af96f934bfc08b869f70000000000000000000000000000002040c65a5efd7f000070c85a5efd7f00000400000003000000d0c65a5efd7f0000000000000000000000000000000000020000000000000001000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f60000000000000002000000000000000100000000000000000000000000000020bfab4c0cb5f9a42b2b9b7b574606437cb1bc719135a8c82d73b53491df46df920000000000000001000000000000000100000000000000209b5aecf08a63bcecb281eafbd55d2efcc0931766837bb23546064c2732b2918a0000000000000003000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f600000000000000020000000000000001000000000000000000000000000000205b48230bf16d87c7cbb75d193410129bfce679cba9a3e3d93b4a95fd7164b226000000000000000100000000000000000000000000000020ef3317577acca48fc1dbaf4b3bdbba08a978d2d2dd88e0f10d311f12921d7ad400000000000000022ccdd9c90f73ed6044929653b96c27da9a85fb6434f2d995318b75e5d35020dc187657b05dc117c7fc140169d98793b2f35956ad726cb2a6c7e02dd841a52a7b00000000000000030f4ddea1978cefa4c7d74dcdf03b17fd391e24c4cd32fc32067f37f873fed96800000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc79003536000000000000000230644e72e131a0241a2988cc74389d96cde5cdbc97894b683d626c78eb81b1a700000000000000059e26bcea0d48bac65a4e1a8be2302529067f891b047e4e56000000000000000400000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca90000000000000003000000000000000100000000000000010000000000000020e5a2d1c4f990b34d8b080880ddfb17316ae7d88122d8b12c89d1eaf303db3c9400000000000000010000000000000001000000000000002030f4527353532d2e25bc497c2648ab07e0cf132fa613237fb3f7cc897c8df69b00000000000000010000000000000000000000000000002077d9a4c40566e6eda342b871662e80914a918d208a6eb9a72045676fc8dbc1120000000000000002000000000000000400000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc79003536000000000000000400000000000000010000000000000001000000000000002098933caf4e64b72e53030c35166a6b709eaa309f04280fcb49b138b78d2182330000000000000001000000000000000100000000000000201631f007544f0a857330bc2a777aedd26905c9e7def7f4b21e776b1d49794730000000000000000100000000000000000000000000000020ad5faa0795ad48ddd74cc5f8553d73df66d9a9719d03c2b9c7e9a75172457ebe00000000000000010000000000000001000000000000002072697671d9683845d813b5b609a51e9e1c398b1ae9e2fecd065680155b0c6550000000000000000c00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000004000000000000000100000000000000010000000000000020300b58bfb9b4d9f23116fbb21ffdf6b0b0d1b5ec21dc7a650e8f867c95ef1e3900000000000000010000000000000001000000000000002061c153133c33dda131c8f208caabd332d7a8882e4c4c3594b8ad55201fee7a2a0000000000000001000000000000000000000000000000203d7881e38b2267cb5d42b352ea67fb1adf179e0fe7797ba17f6f60be930eab97000000000000000100000000000000000000000000000020ff58fff29fd22036c585d43655b2a2e930aaccffa097d22c96f45c4f101223c8194bd943b12560c514bea7e441775f43499ba1e673b06d928d230469fd6e857d00000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca900000000000000020f4ddea1978cefa4c7d74dcdf03b17fd391e24c4cd32fc32067f37f873fed968016252b713ded281d579e8d5682134ef0b94ad958558f02a4cb7cf9f54a0c5d3000000000000000000000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002000000000000000100000000000000010000000000000020055c5a5c315ffdab1d5d764a01f20e1642654c734beb3aa0c80d95d6d80bb8bf00000000000000010000000000000001000000000000002055984fefe3b5f7107abe88b4ed6c68b551df4217ada0a559cfed17d555d006070000000000000002000000000000000400000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca90000000000000003000000000000000100000000000000010000000000000020e5a2d1c4f990b34d8b080880ddfb17316ae7d88122d8b12c89d1eaf303db3c9400000000000000010000000000000001000000000000002030f4527353532d2e25bc497c2648ab07e0cf132fa613237fb3f7cc897c8df69b00000000000000010000000000000000000000000000002077d9a4c40566e6eda342b871662e80914a918d208a6eb9a72045676fc8dbc112000000000000000000000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca900000000000000030000000000000001000000000000000100000000000000200216f102ba4fcb567c8273e663d85b451dae3318a314ff108c6e6aa3f5b2cac8000000000000000100000000000000010000000000000020105c4bcd056907959bc9151574ab2c233c2910ca4019b6b24eaae5ccc9bd2b70000000000000000100000000000000010000000000000020887aabb38c8179d7bdcf870179d0e13844b9b380623d6cae8ac9e789929140b714dfe3068c0364fe885652071172633065ab69c92da61baab589ae2a24f54b5600000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002194bd943b12560c514bea7e441775f43499ba1e673b06d928d230469fd6e857d27dcbd13c9e17b771a340a2c37c93a87e3475de72f9c52650658276cf1e4ccd30000000000000000000000000000002040c65a5efd7f000070c85a5efd7f00000400000003000000d0c65a5efd7f000000000000000000000000000000000002000000000000000000000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002000000000000000100000000000000010000000000000020055c5a5c315ffdab1d5d764a01f20e1642654c734beb3aa0c80d95d6d80bb8bf00000000000000010000000000000001000000000000002055984fefe3b5f7107abe88b4ed6c68b551df4217ada0a559cfed17d555d00607000000000000000200000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002000000000000000100000000000000010000000000000020ce08e95b573f6b192995f97b211eafcc971fbb1c217fad11ec4c919fe141b5c20000000000000001000000000000000000000000000000203dcf6d8669153cd06dbe056daa7a340179eb1f77703d0ae4bc64ddd35d3fd08d000000000000000214ad0d275985f520ba97143109b2e598b8ccc7dd75d08ef66dcaeb121de6a52907a3fb74a10f1114879a1573dca674474a990c7cb325ff106a4b801e8c6fe1fe00000000000000031b74924f9e1932fb248147ae20fb65ae7b6a79ffbc15b94d06f7bad9613116ef00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000020a3a9f7d33a184d13887390927d64f5b57b6e8c76e4b9215dc0402c6040588cc2629aef5ad901b57183f5d72d658da5039e978de12e1d531263e10872adae3a5000000000000000200000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000030000000000000001000000000000000100000000000000205180c4a9d5f8c3ba20dd9191a66cc2c896c9665137dfeb3718b75db1de03d8c1000000000000000100000000000000000000000000000020668fd05cbad02f2599914105d3b60cd84cf97f9727e07c77e500d5a1af3c7cc60000000000000001000000000000000100000000000000208a8ebf5272d1733030c47dd710f6055bffbe488b4e54bd4cd5f79cd64a97c7b40000000000000002000000000000000200000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000040000000000000001000000000000000100000000000000208c70b2a4d4bf0a446ca0a3aef3bbf0703c67ae4dfdaf990ca3968dbdffa4a21a000000000000000100000000000000000000000000000020f7921556c3601046d5b782240bb4f5bbb00e47f67b53846bff3ce71268a84abd0000000000000001000000000000000100000000000000205194a231165353123cbe4940bdbee3c1e726f8ed8ab5c6f5632d9353a2e8496d00000000000000010000000000000001000000000000002072697671d9683845d813b5b609a51e9e1c398b1ae9e2fecd065680155b0c6550000000000000000a00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000004000000000000000100000000000000010000000000000020a1278239f7685e35a460d6bdd510a3768172573d6a47e8a4e5121827633e2b53000000000000000100000000000000000000000000000020e2f8945e4898a7b897af6f417af1d6067b4d415b90df5cc767061065b4b1e94d0000000000000001000000000000000100000000000000204588fe9e87ee6f31163531890c67d678d24c4494821a1028f0f465520ff379e3000000000000000100000000000000000000000000000020ff58fff29fd22036c585d43655b2a2e930aaccffa097d22c96f45c4f101223c826b0902e3b5b6fbf18fe0993375881b8b34c1cc4b04fb178f038c762333e75da00000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000021b74924f9e1932fb248147ae20fb65ae7b6a79ffbc15b94d06f7bad9613116ef2959ffd943c8e244d7d529ec2f11ecf8aee527139917336171c6986a07365772000000000000000200000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c368071000000000000000200000000000000010000000000000001000000000000002057d67b6c2dc62ddbbf885935f77b8a52cfb6745ca4920b38d045d6a62977ea8400000000000000010000000000000000000000000000002006710d01f42e66cbedc04459fde055770b57db2f23aa3d1cabb8a23349100fd80000000000000002000000000000000200000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000030000000000000001000000000000000100000000000000205180c4a9d5f8c3ba20dd9191a66cc2c896c9665137dfeb3718b75db1de03d8c1000000000000000100000000000000000000000000000020668fd05cbad02f2599914105d3b60cd84cf97f9727e07c77e500d5a1af3c7cc60000000000000001000000000000000100000000000000208a8ebf5272d1733030c47dd710f6055bffbe488b4e54bd4cd5f79cd64a97c7b4000000000000000600000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000030000000000000001000000000000000100000000000000209a53f5e310640dde2ea5f4224687f2bee8da9907329166a70b1972c159c0f5580000000000000001000000000000000000000000000000201a4e6f2311f88380880589b3007eae8c66bdf9ddc9dd7a5982a4b392cd0baa65000000000000000100000000000000000000000000000020ac8fea8c2de5836168be1a8e51cead52f93c7fec6bdeafba7d20fc0151417b171c51089bfa950635423129a4e65959e00365d45a28f68e06d8166b30aa56872700000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c368071000000000000000226b0902e3b5b6fbf18fe0993375881b8b34c1cc4b04fb178f038c762333e75da2e064dc98e373407a42705cbd2a6dfaf6e95d098faf293c7b33fca738f416e8d0000000000000000000000000000002040c65a5efd7f000070c85a5efd7f00000400000003000000d0c65a5efd7f000000000000000000000000000000000002000000000000000200000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c368071000000000000000200000000000000010000000000000001000000000000002057d67b6c2dc62ddbbf885935f77b8a52cfb6745ca4920b38d045d6a62977ea8400000000000000010000000000000000000000000000002006710d01f42e66cbedc04459fde055770b57db2f23aa3d1cabb8a23349100fd8000000000000000000000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c36807100000000000000020000000000000001000000000000000100000000000000209a97ff33d87ab17c8a10cdd6748d40ec44dec1581147e33b765e57f89d3d3ce1000000000000000100000000000000010000000000000020d301079fb4b9365db6d7a19e5e19557ee2b9210e93f8c392c71131ac69a53fb8";
        bytes memory init_blob = hex"00010203040506070809";
        types.transcript_data memory tr_state;
        transcript.init_transcript(tr_state, init_blob);
        types.fri_params_type memory fri_params;
        fri_params.modulus = modulus;
        fri_params.r = 3;
        fri_params.max_degree = 15;
        fri_params.D_omegas = new uint256[](fri_params.r);
        fri_params.D_omegas[0] = 14940766826517323942636479241147756311199852622225275649687664389641784935947;
        fri_params.D_omegas[1] = 19540430494807482326159819597004422086093766032135589407132600596362845576832;
        fri_params.D_omegas[2] = 21888242871839275217838484774961031246007050428528088939761107053157389710902;
        fri_params.q = new uint256[](3);
        fri_params.q[0] = 0;
        fri_params.q[1] = 0;
        fri_params.q[2] = 1;
        types.lpc_params_type memory lpc_params;
        lpc_params.modulus = modulus;
        lpc_params.lambda = 3;
        lpc_params.r = 3;
        lpc_params.m = 2;
        lpc_params.fri_params = fri_params;
        uint256[] memory evaluation_points = new uint256[](1);
        evaluation_points[0] = 5;
        (types.lpc_proof_type memory proof, uint256 proof_size) = lpc_verifier.parse_proof_be(raw_proof, 0);
        Assert.equal(raw_proof.length, proof_size, "Proof length is not correct");
        Assert.equal(raw_proof.length, lpc_verifier.skip_proof_be(raw_proof, 0), "Skipping proof is not correct!");
        bool result = lpc_verifier.verifyProof(evaluation_points, proof, tr_state, lpc_params);
        Assert.equal(true, result, "Proof is not correct");
    }

    function test_lpc_proof_raw_verification_d16() public {
        // bn254 scalar field
        uint256 modulus = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        bytes memory raw_proof = hex"00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000001000000000000000000000000000000000000000000000000000000093c3fd5c4000000000000000300000000000000020d290fcf4d9880f934970cc30d943c97a4bca78fcfa4b59fc4f1dcfffbf5d90d1e89d09fb2cf975e1a93b0f9659074117acd0d049a9a5445cfb3857c4eafa8e100000000000000031096b25766820f869d1063a7e5ab016df4b8a0b8bfa9739d7e9d0705f3c892c000000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000020559201106e80dedf628230cd76d081bf8b42137cf2c9d6bb862f2fbcafd37a31278f47c764d688ed5ea487d2cd262139c57874aa1b1c5406e59ac5ae0597dba0000000000000001000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf860000000000000003000000000000000100000000000000000000000000000020b4de53960b02deaa73a50c20b9bc745da743bdd4d08a40442ee757745df5455700000000000000010000000000000001000000000000002058acfb8892e18e2cfb2b3adcb50bfdcb56903f02ba4bc77b1c970c2a4949ac000000000000000001000000000000000100000000000000201e9cf6673864e7364b2619c142a4e113ea2495907f2dbd7c7a8a878589ead8890000000000000002000000000000000100000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000004000000000000000100000000000000000000000000000020c6bb06cb7f92603de181bf256cd16846b93b752a170ff24824098b31aa008a7e0000000000000001000000000000000100000000000000206926cc6f9563da8fa6836177688ebfd52e3446c2e344d37949a222802a94eee70000000000000001000000000000000100000000000000205194a231165353123cbe4940bdbee3c1e726f8ed8ab5c6f5632d9353a2e8496d00000000000000010000000000000001000000000000002072697671d9683845d813b5b609a51e9e1c398b1ae9e2fecd065680155b0c6550000000000000000900000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000040000000000000001000000000000000000000000000000208a35acfbc15ff81a39ae7d344fd709f28e8600b4aa8c65c6b64bfe7fe36bd19b000000000000000100000000000000010000000000000020f30cd4b26a02d9e7718d60239f2256ee5ed5c5abfb059c08afa921df0b4cb30f0000000000000001000000000000000100000000000000204588fe9e87ee6f31163531890c67d678d24c4494821a1028f0f465520ff379e3000000000000000100000000000000000000000000000020ff58fff29fd22036c585d43655b2a2e930aaccffa097d22c96f45c4f101223c815129f22d89d9f177f2bef167f2bebff6f1f053ea8efce60b2729eb5d6b7fca7000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf8600000000000000021096b25766820f869d1063a7e5ab016df4b8a0b8bfa9739d7e9d0705f3c892c00100e08088a0fc78dae25e6ca97531359118ec3c519327c73b112609da091a9c0000000000000001000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f60000000000000002000000000000000100000000000000000000000000000020bfab4c0cb5f9a42b2b9b7b574606437cb1bc719135a8c82d73b53491df46df920000000000000001000000000000000100000000000000209b5aecf08a63bcecb281eafbd55d2efcc0931766837bb23546064c2732b2918a00000000000000020000000000000001000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf860000000000000003000000000000000100000000000000000000000000000020b4de53960b02deaa73a50c20b9bc745da743bdd4d08a40442ee757745df5455700000000000000010000000000000001000000000000002058acfb8892e18e2cfb2b3adcb50bfdcb56903f02ba4bc77b1c970c2a4949ac000000000000000001000000000000000100000000000000201e9cf6673864e7364b2619c142a4e113ea2495907f2dbd7c7a8a878589ead8890000000000000005000000000000002089ffef10298d75442953c55f49ab403ac8aba5dfff26cae891f7da6da89eaf860000000000000003000000000000000100000000000000000000000000000020f3d4b9dc2076341e8ad25dffbd467bc8e06cb910966771fd65e0dc2cd64001220000000000000001000000000000000100000000000000208fa8a9e215a9b8a70dde00e8b2b9ee97eb237b0197775eb989a18545b2ea1dd90000000000000001000000000000000000000000000000200f3152c8e1a84e494393fe3413f931112a52cca6b24dea3e3de57518257cf3671f038da27bfa89c4d253a180298520e3522382d3aec3d1eb39204d179d46302d000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f6000000000000000215129f22d89d9f177f2bef167f2bebff6f1f053ea8efce60b2729eb5d6b7fca706bc0a25ec560c40cd3552712f86ba3ab317177ef9e82af96f934bfc08b869f70000000000000000000000000000002040c65a5efd7f000070c85a5efd7f00000400000003000000d0c65a5efd7f0000000000000000000000000000000000020000000000000001000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f60000000000000002000000000000000100000000000000000000000000000020bfab4c0cb5f9a42b2b9b7b574606437cb1bc719135a8c82d73b53491df46df920000000000000001000000000000000100000000000000209b5aecf08a63bcecb281eafbd55d2efcc0931766837bb23546064c2732b2918a0000000000000003000000000000002092cad6b6dc11265ace0231dab76bbd850f777478ec08c9745f09bac21d8352f600000000000000020000000000000001000000000000000000000000000000205b48230bf16d87c7cbb75d193410129bfce679cba9a3e3d93b4a95fd7164b226000000000000000100000000000000000000000000000020ef3317577acca48fc1dbaf4b3bdbba08a978d2d2dd88e0f10d311f12921d7ad400000000000000022ccdd9c90f73ed6044929653b96c27da9a85fb6434f2d995318b75e5d35020dc187657b05dc117c7fc140169d98793b2f35956ad726cb2a6c7e02dd841a52a7b00000000000000030f4ddea1978cefa4c7d74dcdf03b17fd391e24c4cd32fc32067f37f873fed96800000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc79003536000000000000000230644e72e131a0241a2988cc74389d96cde5cdbc97894b683d626c78eb81b1a700000000000000059e26bcea0d48bac65a4e1a8be2302529067f891b047e4e56000000000000000400000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca90000000000000003000000000000000100000000000000010000000000000020e5a2d1c4f990b34d8b080880ddfb17316ae7d88122d8b12c89d1eaf303db3c9400000000000000010000000000000001000000000000002030f4527353532d2e25bc497c2648ab07e0cf132fa613237fb3f7cc897c8df69b00000000000000010000000000000000000000000000002077d9a4c40566e6eda342b871662e80914a918d208a6eb9a72045676fc8dbc1120000000000000002000000000000000400000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc79003536000000000000000400000000000000010000000000000001000000000000002098933caf4e64b72e53030c35166a6b709eaa309f04280fcb49b138b78d2182330000000000000001000000000000000100000000000000201631f007544f0a857330bc2a777aedd26905c9e7def7f4b21e776b1d49794730000000000000000100000000000000000000000000000020ad5faa0795ad48ddd74cc5f8553d73df66d9a9719d03c2b9c7e9a75172457ebe00000000000000010000000000000001000000000000002072697671d9683845d813b5b609a51e9e1c398b1ae9e2fecd065680155b0c6550000000000000000c00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000004000000000000000100000000000000010000000000000020300b58bfb9b4d9f23116fbb21ffdf6b0b0d1b5ec21dc7a650e8f867c95ef1e3900000000000000010000000000000001000000000000002061c153133c33dda131c8f208caabd332d7a8882e4c4c3594b8ad55201fee7a2a0000000000000001000000000000000000000000000000203d7881e38b2267cb5d42b352ea67fb1adf179e0fe7797ba17f6f60be930eab97000000000000000100000000000000000000000000000020ff58fff29fd22036c585d43655b2a2e930aaccffa097d22c96f45c4f101223c8194bd943b12560c514bea7e441775f43499ba1e673b06d928d230469fd6e857d00000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca900000000000000020f4ddea1978cefa4c7d74dcdf03b17fd391e24c4cd32fc32067f37f873fed968016252b713ded281d579e8d5682134ef0b94ad958558f02a4cb7cf9f54a0c5d3000000000000000000000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002000000000000000100000000000000010000000000000020055c5a5c315ffdab1d5d764a01f20e1642654c734beb3aa0c80d95d6d80bb8bf00000000000000010000000000000001000000000000002055984fefe3b5f7107abe88b4ed6c68b551df4217ada0a559cfed17d555d006070000000000000002000000000000000400000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca90000000000000003000000000000000100000000000000010000000000000020e5a2d1c4f990b34d8b080880ddfb17316ae7d88122d8b12c89d1eaf303db3c9400000000000000010000000000000001000000000000002030f4527353532d2e25bc497c2648ab07e0cf132fa613237fb3f7cc897c8df69b00000000000000010000000000000000000000000000002077d9a4c40566e6eda342b871662e80914a918d208a6eb9a72045676fc8dbc112000000000000000000000000000000204a6b3b11e6a1118081ef484f3aacc8c26e49c747a5e5d83793e50c55a5b26ca900000000000000030000000000000001000000000000000100000000000000200216f102ba4fcb567c8273e663d85b451dae3318a314ff108c6e6aa3f5b2cac8000000000000000100000000000000010000000000000020105c4bcd056907959bc9151574ab2c233c2910ca4019b6b24eaae5ccc9bd2b70000000000000000100000000000000010000000000000020887aabb38c8179d7bdcf870179d0e13844b9b380623d6cae8ac9e789929140b714dfe3068c0364fe885652071172633065ab69c92da61baab589ae2a24f54b5600000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002194bd943b12560c514bea7e441775f43499ba1e673b06d928d230469fd6e857d27dcbd13c9e17b771a340a2c37c93a87e3475de72f9c52650658276cf1e4ccd30000000000000000000000000000002040c65a5efd7f000070c85a5efd7f00000400000003000000d0c65a5efd7f000000000000000000000000000000000002000000000000000000000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002000000000000000100000000000000010000000000000020055c5a5c315ffdab1d5d764a01f20e1642654c734beb3aa0c80d95d6d80bb8bf00000000000000010000000000000001000000000000002055984fefe3b5f7107abe88b4ed6c68b551df4217ada0a559cfed17d555d00607000000000000000200000000000000209e1270ac710c44b66a8ea892c15c2e46756dd98e3a193775ee7d88008aa74a370000000000000002000000000000000100000000000000010000000000000020ce08e95b573f6b192995f97b211eafcc971fbb1c217fad11ec4c919fe141b5c20000000000000001000000000000000000000000000000203dcf6d8669153cd06dbe056daa7a340179eb1f77703d0ae4bc64ddd35d3fd08d000000000000000214ad0d275985f520ba97143109b2e598b8ccc7dd75d08ef66dcaeb121de6a52907a3fb74a10f1114879a1573dca674474a990c7cb325ff106a4b801e8c6fe1fe00000000000000031b74924f9e1932fb248147ae20fb65ae7b6a79ffbc15b94d06f7bad9613116ef00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000020a3a9f7d33a184d13887390927d64f5b57b6e8c76e4b9215dc0402c6040588cc2629aef5ad901b57183f5d72d658da5039e978de12e1d531263e10872adae3a5000000000000000200000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000030000000000000001000000000000000100000000000000205180c4a9d5f8c3ba20dd9191a66cc2c896c9665137dfeb3718b75db1de03d8c1000000000000000100000000000000000000000000000020668fd05cbad02f2599914105d3b60cd84cf97f9727e07c77e500d5a1af3c7cc60000000000000001000000000000000100000000000000208a8ebf5272d1733030c47dd710f6055bffbe488b4e54bd4cd5f79cd64a97c7b40000000000000002000000000000000200000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc7900353600000000000000040000000000000001000000000000000100000000000000208c70b2a4d4bf0a446ca0a3aef3bbf0703c67ae4dfdaf990ca3968dbdffa4a21a000000000000000100000000000000000000000000000020f7921556c3601046d5b782240bb4f5bbb00e47f67b53846bff3ce71268a84abd0000000000000001000000000000000100000000000000205194a231165353123cbe4940bdbee3c1e726f8ed8ab5c6f5632d9353a2e8496d00000000000000010000000000000001000000000000002072697671d9683845d813b5b609a51e9e1c398b1ae9e2fecd065680155b0c6550000000000000000a00000000000000200f044be55eca548bd7963cc4cfb11adb7a3b043c3f300c80eba0fdcc790035360000000000000004000000000000000100000000000000010000000000000020a1278239f7685e35a460d6bdd510a3768172573d6a47e8a4e5121827633e2b53000000000000000100000000000000000000000000000020e2f8945e4898a7b897af6f417af1d6067b4d415b90df5cc767061065b4b1e94d0000000000000001000000000000000100000000000000204588fe9e87ee6f31163531890c67d678d24c4494821a1028f0f465520ff379e3000000000000000100000000000000000000000000000020ff58fff29fd22036c585d43655b2a2e930aaccffa097d22c96f45c4f101223c826b0902e3b5b6fbf18fe0993375881b8b34c1cc4b04fb178f038c762333e75da00000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000021b74924f9e1932fb248147ae20fb65ae7b6a79ffbc15b94d06f7bad9613116ef2959ffd943c8e244d7d529ec2f11ecf8aee527139917336171c6986a07365772000000000000000200000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c368071000000000000000200000000000000010000000000000001000000000000002057d67b6c2dc62ddbbf885935f77b8a52cfb6745ca4920b38d045d6a62977ea8400000000000000010000000000000000000000000000002006710d01f42e66cbedc04459fde055770b57db2f23aa3d1cabb8a23349100fd80000000000000002000000000000000200000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000030000000000000001000000000000000100000000000000205180c4a9d5f8c3ba20dd9191a66cc2c896c9665137dfeb3718b75db1de03d8c1000000000000000100000000000000000000000000000020668fd05cbad02f2599914105d3b60cd84cf97f9727e07c77e500d5a1af3c7cc60000000000000001000000000000000100000000000000208a8ebf5272d1733030c47dd710f6055bffbe488b4e54bd4cd5f79cd64a97c7b4000000000000000600000000000000205bbc194d21b75d5e77c72be2ca4027d01fe09ef8e5f2aef15cc224cb994e680400000000000000030000000000000001000000000000000100000000000000209a53f5e310640dde2ea5f4224687f2bee8da9907329166a70b1972c159c0f5580000000000000001000000000000000000000000000000201a4e6f2311f88380880589b3007eae8c66bdf9ddc9dd7a5982a4b392cd0baa65000000000000000100000000000000000000000000000020ac8fea8c2de5836168be1a8e51cead52f93c7fec6bdeafba7d20fc0151417b171c51089bfa950635423129a4e65959e00365d45a28f68e06d8166b30aa56872700000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c368071000000000000000226b0902e3b5b6fbf18fe0993375881b8b34c1cc4b04fb178f038c762333e75da2e064dc98e373407a42705cbd2a6dfaf6e95d098faf293c7b33fca738f416e8d0000000000000000000000000000002040c65a5efd7f000070c85a5efd7f00000400000003000000d0c65a5efd7f000000000000000000000000000000000002000000000000000200000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c368071000000000000000200000000000000010000000000000001000000000000002057d67b6c2dc62ddbbf885935f77b8a52cfb6745ca4920b38d045d6a62977ea8400000000000000010000000000000000000000000000002006710d01f42e66cbedc04459fde055770b57db2f23aa3d1cabb8a23349100fd8000000000000000000000000000000200406a73d2313e87e8c4747596f60fb7259bdf60d42c6f61a92b5b7213c36807100000000000000020000000000000001000000000000000100000000000000209a97ff33d87ab17c8a10cdd6748d40ec44dec1581147e33b765e57f89d3d3ce1000000000000000100000000000000010000000000000020d301079fb4b9365db6d7a19e5e19557ee2b9210e93f8c392c71131ac69a53fb8";
        bytes memory init_blob = hex"00010203040506070809";
        types.transcript_data memory tr_state;
        transcript.init_transcript(tr_state, init_blob);
        types.fri_params_type memory fri_params;
        fri_params.modulus = modulus;
        fri_params.r = 3;
        fri_params.max_degree = 15;
        fri_params.D_omegas = new uint256[](fri_params.r);
        fri_params.D_omegas[0] = 14940766826517323942636479241147756311199852622225275649687664389641784935947;
        fri_params.D_omegas[1] = 19540430494807482326159819597004422086093766032135589407132600596362845576832;
        fri_params.D_omegas[2] = 21888242871839275217838484774961031246007050428528088939761107053157389710902;
        fri_params.q = new uint256[](3);
        fri_params.q[0] = 0;
        fri_params.q[1] = 0;
        fri_params.q[2] = 1;
        types.lpc_params_type memory lpc_params;
        lpc_params.modulus = modulus;
        lpc_params.lambda = 3;
        lpc_params.r = 3;
        lpc_params.m = 2;
        lpc_params.fri_params = fri_params;
        uint256[] memory evaluation_points = new uint256[](1);
        evaluation_points[0] = 5;
        (bool result1, uint256 proof_size1) = lpc_verifier.parse_verify_proof_be(raw_proof, 0, evaluation_points, tr_state, lpc_params);
        Assert.equal(true, result1, "Proof is not correct!");
        Assert.equal(raw_proof.length, proof_size1, "Proof length is not correct!");
        Assert.equal(raw_proof.length, lpc_verifier.skip_proof_be(raw_proof, 0), "Skipping proof is not correct!");
    }
}
