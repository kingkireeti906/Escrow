// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Escrow {
address public depositor;
address public beneficiary;
address public arbiter;
 bool public isApproved=false;
 event Approved(uint256 balance);
constructor(address _arbiter,address _beneficiary)payable{
    depositor=msg.sender;
    beneficiary=_beneficiary;
    arbiter=_arbiter;
}
function approve()external{
    require(arbiter == msg.sender, "Only the arbiter can approve");
    uint balance=address(this).balance;
    //two ways to send balance beneficary to transfer
     payable(beneficiary).transfer(address(this).balance);
     // Use .call() to transfer Ether to the beneficiary
        (bool success, ) = beneficiary.call{value: address(this).balance}("");
         require(success, "Transfer failed!"); // Ensure the transfer succeeded
    emit Approved (balance);
     isApproved=true;
    
}



}