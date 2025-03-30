pragma solidity >=0.5.0 <0.6.0;
import "./zombiefactory.sol";
contract KittyInterface { //CryptoKitties의 컨트랙트에서 getKitty(uint256 _id) 함수를 호출하여 특정 Kitty의 정보를 가져올 수 있도록 정의한 인터페이스입니다
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}
contract ZombieFeeding is ZombieFactory {

    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
        require(msg.sender == zombieToOwner[_zombieId]); // 좀비 소유자만 가능하게 함
        Zombie storage myZombie = zombies[_zombieId]; // 해당 좀비 가져오기
        _targetDna = _targetDna % dnaModulus; // dna 16자리 제한
        uint newDna = (myZombie.dna + _targetDna) / 2; // 목표 + 현재 = 평균
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99; // kitty를 먹었을 경우 DNA의 마지막 두 자리를 99로 변경하여 특별한 유형의 좀비를
        }
        _createZombie("NoName", newDna);
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

}
