// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Bullishs is Ownable {
    event BullishsLog(address userAddress, uint256 amount);

    using SafeERC20 for IERC20;

    constructor() Ownable(_msgSender()) {}

    function transfer(
        address token,
        address userAddress,
        uint256 amount
    ) external onlyOwner {
        IERC20(token).safeTransfer(userAddress, amount);
        emit BullishsLog(userAddress, amount);
    }

    function transferNative(
        address userAddress,
        uint256 amount
    ) external onlyOwner {
        (bool sent, ) = payable(userAddress).call{value: amount}("");
        require(sent, "TransferNative: sent failed");
        emit BullishsLog(userAddress, amount);
    }

    function withdraw(address token, uint256 amount) external onlyOwner {
        IERC20(token).safeTransfer(msg.sender, amount);
    }

    function withdrawNative(uint256 amount) external onlyOwner {
        (bool sent, ) = payable(owner()).call{value: amount}("");
        require(sent, "WithdrawNative: sent failed");
    }

    receive() external payable {}
}
