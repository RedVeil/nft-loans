//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract AcceptNFTS is ERC721Holder {
    struct Deposit {
        IERC721 nft;
        uint256[] ids;
    }

    mapping(address => Deposit[]) deposits;

    constructor() {}

    function depositNFT(IERC721 nft_, uint256[] memory ids_) external {
        for (uint256 i; i < ids_.length; i++) {
            nft_.safeTransferFrom(msg.sender, address(this), ids_[i]);
        }
        deposits[msg.sender].push(Deposit({nft: nft_, ids: ids_}));
    }

    function addNFTToDeposit(uint256 depositId, uint256[] memory ids_) external {
        Deposit storage deposit = deposits[msg.sender][depositId];
        for (uint256 i; i < ids_.length; i++) {
            deposit.nft.safeTransferFrom(msg.sender, address(this), ids_[i]);
            deposit.ids.push(ids_[i]);
        }
    }

    function getDeposits(address account)
        external
        view
        returns (Deposit[] memory)
    {
        return deposits[account];
    }
}
