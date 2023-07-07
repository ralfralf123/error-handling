// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract ErrorHandling {
    
    string public tokenName = "LACED";
    string public tokenAbbrv = "LCD";
    uint public tokenSupp = 0;
    mapping(address => uint) public balances;

    function mintToken(address _address, uint _value) public {
        require(_value > 0, "Value must be greater than zero.");

        tokenSupp += _value;
        balances[_address] += _value;
    }

    function burnToken(address _address, uint _value) public {
        require(_value > 0, "Value must be greater than zero.");
        require(balances[_address] >= _value, "Insufficient balance.");

        tokenSupp -= _value;
        balances[_address] -= _value;
    }

    error InsufficientBalance(uint requested, uint available);
    
    function sendToken(address _receiver, uint _value) public {
        if(_value > balances[msg.sender] ){
         revert InsufficientBalance({
                requested: _value,
                available: balances[msg.sender]
            });
      }
        
        balances[msg.sender] -= _value;
        balances[_receiver] += _value;

    }

    function depositToken(uint _value) public {
            require(_value > 0, "Value must be greater than zero.");

            balances[msg.sender] += _value;

            assert(balances[msg.sender] >= _value);
        }

}
