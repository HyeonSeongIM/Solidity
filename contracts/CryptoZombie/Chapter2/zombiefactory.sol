pragma solidity >=0.5.0 <0.6.0;

//함수 호출 흐름:
//createRandomZombie → _createZombie
//feedOnKitty → feedAndMultiply → _createZombie

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16; // 좀비 dna 자릿수
    uint dnaModulus = 10 ** dnaDigits; // 16으로 제한

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner; // 특정 좀비가 누구것인지
    mapping (address => uint) ownerZombieCount; // 누구는 좀비를 몇개 가졌나

    function _createZombie(string memory _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender; // 좀비 소유권을 msg.sender 에 줌
        ownerZombieCount[msg.sender]++; // 해당 좀비 갯수 증가
        emit NewZombie(id, _name, _dna);
    }

    // view = 읽기 전용
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0); // 1개만 생성가능하게
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100; // 마지막 두자리 00으로 두고 쉽게 구분하게
        _createZombie(_name, randDna);
    }

}
