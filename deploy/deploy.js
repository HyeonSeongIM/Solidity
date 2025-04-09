const hre = require("hardhat");

async function main() {
    const MyNFT = await hre.ethers.getContractFactory("MyNFT");
    const myNFT = await MyNFT.deploy();
    await myNFT.waitForDeployment();

    console.log("NFT Contract deployed to:", myNFT.target);

    // GitHub에 업로드된 JSON 주소로 테스트용 민팅
    const tokenURI = "https://raw.githubusercontent.com/HyeonSeongIM/SolidityStudy/main/assets/images/0.png"
    const tx = await myNFT.mintNFT("0x5FbDB2315678afecb367f032d93F642f64180aa3", tokenURI);
    await tx.wait();
    console.log("NFT minted successfully!");
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
