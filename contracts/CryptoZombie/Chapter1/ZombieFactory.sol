pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna); // 트랜잭션

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie { // 좀비 객체
        string name;
        uint dna;
    }

    Zombie[] public zombies; // 배열 (zombies)

    // 좀비 생성 메서드
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1; // id = 배열 push 후 길이 - 1
        emit NewZombie(id, _name, _dna); // 트랜잭션 시작
    }

    // 랜덤 숫자 생성
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // 랜덤 좀비 생성
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
