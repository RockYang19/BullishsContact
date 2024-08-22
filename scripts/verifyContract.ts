import hre, { ethers } from "hardhat";

async function main(): Promise<void> {
  const contractAddress = "0xAd2803cDBfFc8bae61eeC0A1CF849877f0E742Bd";
  const currentNetwork = hre.network.name;

  if (contractAddress) {
    console.log("Verify Bullishs");
    try {
      await hre.run("verify:verify", {
        address: contractAddress,
        constructorArguments: [],
      });
    } catch (error) {
      console.error(error);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
