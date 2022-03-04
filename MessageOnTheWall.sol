// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


import "./Owner.sol";

contract MessageOnTheWall is Owner{

    string message;
    string author;
    address authorAddress;
    uint256 timeStamp;

    constructor(){
        message="START!";
        author="comeidone";
        authorAddress=msg.sender;
        timeStamp=block.timestamp;
    }

    function writeMessage(string memory _message, string memory _author) public payable{
        require(bytes(_message).length > 0,"Message is empty!");
        require(bytes(_author).length > 0,"Author is empty!");
        require(msg.value >= 0.00001 ether,"Give me at least 0.00001 ETH!");
        message = _message;
        author = _author;
        authorAddress =msg.sender;
        timeStamp = block.timestamp;
    }


    function readMessage() public view returns (string memory,string memory,address,uint256){
        return (message, author, authorAddress,timeStamp);
    }

    function withdraw() public isOwner{
        address payable addressTo=payable(address(super.getOwner()));
        addressTo.transfer(address(this).balance);
    }

    function getBalance() public view isOwner returns(uint256){
       return address(this).balance;
    }

}
