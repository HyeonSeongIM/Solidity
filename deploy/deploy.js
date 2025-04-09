const hre = require("hardhat");

async function main() {
    const MyNFT = await hre.ethers.getContractFactory("MyNFT");
    const myNFT = await MyNFT.deploy();
    await myNFT.waitForDeployment();

    console.log("NFT Contract deployed to:", myNFT.target);

    // GitHub에 업로드된 JSON 주소로 테스트용 민팅
    const tokenURI = "https://raw.githubusercontent.com/hyeonseongIM/solidyStudy/main/assets/images/0.png"
    const tx = await myNFT.mintNFT("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", tokenURI);
    await tx.wait();
    console.log("NFT minted successfully!");
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
