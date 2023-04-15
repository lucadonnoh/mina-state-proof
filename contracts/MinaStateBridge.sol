// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./protocol/state.sol";

interface IMailbox {
    function dispatch(
        uint32 _destinationDomain,
        bytes32 _recipientAddress,
        bytes calldata _messageBody
    ) external returns (bytes32);
}

interface IIMinaPlaceholderVerifier {
    function verifyLedgerState(string calldata ledger_hash, bytes calldata proof, uint256[][] calldata init_params,
        int256[][][] calldata columns_rotations) external returns (bool);
}

contract MinaStateBridge {
    IMailbox immutable hyperlaneMailbox;
    IIMinaPlaceholderVerifier immutable minaPlaceholderVerifier;

    constructor(address _hyperlaneMailbox, address _minaPlaceholderVerifier) {
        hyperlaneMailbox = IMailbox(_hyperlaneMailbox);
        minaPlaceholderVerifier = IIMinaPlaceholderVerifier(_minaPlaceholderVerifier);
    }

    function relayState(state.account_state calldata account_state, string calldata ledger_hash,
        bytes calldata proof, uint256[][] calldata init_params,
        int256[][][] calldata columns_rotations,
        uint32 _destinationDomain,
        bytes32 _recipientAddress
    ) public {
        require(minaPlaceholderVerifier.verifyLedgerState(ledger_hash, proof, init_params, columns_rotations), "Invalid Mina state");
        bytes memory messageBody = abi.encode(account_state.state[0]);
        hyperlaneMailbox.dispatch(_destinationDomain, _recipientAddress, messageBody);
    }
}