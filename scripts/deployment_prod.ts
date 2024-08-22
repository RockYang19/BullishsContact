import { ethers } from "hardhat";
import { deployerConfiguration, getDeployParametersProd } from "./utils";

export async function deployment() {
  const deployer = await deployerConfiguration();
  const deployParameters = await getDeployParametersProd();
  console.log("deployer: ", await deployer.getAddress());
  if ((await deployer.getAddress()) != deployParameters.deployer) {
    throw new Error("deployer mismatch, please check deployer private key");
  }

  const contractName = "Bullishs";
  const contractFactory = await ethers.getContractFactory(contractName);

  const contract = await contractFactory
    .connect(deployer)
    .deploy();

  console.log(await contract.getAddress());
}

deployment()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(() => {
    // exit the script
    process.exit();
  });
