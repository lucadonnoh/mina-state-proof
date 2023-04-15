// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IMinaStateBridge {
    function relayState(state.account_state calldata account_state, string calldata ledger_hash,
        bytes calldata proof, uint256[][] calldata init_params,
        int256[][][] calldata columns_rotations,
        uint32 _destinationDomain,
        bytes32 _recipientAddress
    ) external;
}