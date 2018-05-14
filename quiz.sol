pragma solidity ^0.4.20;

contract Quiz
{

    uint private previousNumber;
    
    uint private questionID;

    constructor() public
    {
        questionID = 0;
    }
    
    /*----------------------------
    Description: generate new quiz based on level (from 1 to 2)
    Input:
        + _level: 1 - Add/Subtract; 2 - Multiply/Divide
        + _max: Maximum number of each operand
    Outputs:
        + _id: Question ID (this is auto-number)
        + _a: Left operand
        + _b: Right operand
        + _ops: Operator; 0: Add; 1: Subtract; 2: Multiply; 3: Divide
    ----------------------------*/
    
    function generateQuiz(uint8 _level, uint _max) public returns (uint _id, uint _a, uint _b, uint _ops)
    {
        uint a = random(_max);
        uint b = random(_max);
        uint ops = random(_level == 1 ? 2 : 4);

        questionID = questionID + 1;
        
        return (questionID, a, b, ops);
    }
    
    function random(uint _max) private returns (uint)
    {
        uint lastBlockNumber = block.number - 1;
        uint hashVal = uint(block.blockhash(lastBlockNumber));
        uint timestamp = block.timestamp;
        
        uint number = uint256(keccak256(lastBlockNumber, hashVal, previousNumber, timestamp));

        previousNumber = number;
        
        return number % _max;
    }
}