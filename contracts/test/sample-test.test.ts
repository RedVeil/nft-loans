import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { AcceptNFTS, ERC721Mock } from "contracts/typechain";
import { Contract } from "ethers";
import { parseEther } from "ethers/lib/utils";
import { ethers, waffle } from "hardhat";

const provider = waffle.provider;

interface Contracts {
  acceptNFTS: AcceptNFTS;
  cats: ERC721Mock;
  dogs: ERC721Mock;
}

let owner: SignerWithAddress, user: SignerWithAddress;
let contracts: Contracts;

async function deployContracts() {
  const ERC721Mock = await ethers.getContractFactory("ERC721Mock");
  const cats = await (await ERC721Mock.deploy("Cats", "CAT")).deployed();
  const dogs = await (await ERC721Mock.deploy("Dogs", "DOG")).deployed();
  const AcceptNFTS = await ethers.getContractFactory("AcceptNFTS");
  const acceptNFTS = await (await AcceptNFTS.deploy()).deployed();
  return { acceptNFTS, cats, dogs };
}

describe("AcceptNFTS", function () {
  beforeEach(async function () {
    [owner, user] = await ethers.getSigners();
    contracts = await deployContracts();
  });
  it("deposits single token", async function () {
    await contracts.cats.mint(owner.address, 0);
    await contracts.cats.setApprovalForAll(contracts.acceptNFTS.address, true);
    await contracts.acceptNFTS.depositNFT(contracts.cats.address, [0]);
    const deposits = await contracts.acceptNFTS.getDeposits(owner.address);
    console.log(deposits.toString());
  });

  it("deposits multiple token", async function () {
    await contracts.cats.mint(owner.address, 0);
    await contracts.cats.mint(owner.address, 1);
    await contracts.cats.setApprovalForAll(contracts.acceptNFTS.address, true);
    await contracts.acceptNFTS.depositNFT(contracts.cats.address, [0, 1]);
    const deposits = await contracts.acceptNFTS.getDeposits(owner.address);
    console.log(deposits.toString());
  });

  it("add token to deposit", async function () {
    await contracts.cats.mint(owner.address, 0);
    await contracts.cats.mint(owner.address, 1);
    await contracts.cats.setApprovalForAll(contracts.acceptNFTS.address, true);
    await contracts.acceptNFTS.depositNFT(contracts.cats.address, [0]);
    await contracts.acceptNFTS.addNFTToDeposit(0,[1])
    const deposits = await contracts.acceptNFTS.getDeposits(owner.address);
    console.log(deposits.toString());
  });
});
