// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Deployed to Goerli at 0xE5E9331288381Cb69DCBa192729b34d6F102CcE3

contract BuyMeACoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos received from friends.
    Memo[] memos;

    // Address of contract deployer.
    address payable owner;

    // Deploy logic.
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for a contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message from the coffee buyer
     */

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth");
        
        // Add the memo to storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is created !
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev retrieve all the memos received and stored on the blockchain
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;

    }

    //Change Withdrawal address
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    function changeAddress() public {
        address payable to = owner;
        to.transfer(getBalance());
    }

    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(getBalance());
    }
}
