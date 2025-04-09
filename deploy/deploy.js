// scripts/deploy.js
const hre = require("hardhat");

async function main() {
    const MyNFT = await hre.ethers.getContractFactory("MyNFT");
    const myNFT = await MyNFT.deploy();
    await myNFT.waitForDeployment();

    console.log("✅ NFT Contract deployed to:", myNFT.target);

    const tokenURI = "https://raw.githubusercontent.com/HyeonSeongIM/SolidityStudy/main/assets/metadata/0.json";

    const [owner] = await hre.ethers.getSigners();
    const tx = await myNFT.mintNft(owner.address, tokenURI);
    const receipt = await tx.wait();

    console.log("✅ NFT minted successfully!");
    console.log("✅ Transaction Hash:", receipt.hash);
    console.log("✅ NFT Account:", owner.address);
    console.log("✅ Metadata Link:", tokenURI);
    console.log("✅ Image:", "https://raw.githubusercontent.com/HyeonSeongIM/SolidityStudy/main/assets/images/0.png");
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
