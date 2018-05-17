pragma solidity ^0.4.11;

//import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import '../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol';
//import './Ownable.sol';

contract EventTicket is Ownable {

//    struct TicketGroup {
//        bytes32 name;
//        Ticket[] tickets;
//    }

    struct Ticket {
        bytes32 code;
        uint price;
        bool purchased;
    }

    mapping (bytes32 => Ticket) public tickets;

    mapping (address => Ticket) public sales;

    address public eventOwner;

    bytes32 public eventName;

    uint public eventGross;

    uint public value;

//    mapping (bytes32 => TicketGroup) ticketGroups;

    address[] administrators;

    bytes placeSchema; // схема места и тикетов на ней


    function EventTicket(bytes32 name)
    {
        eventOwner = msg.sender;
        eventName  = name;
    }


    function changeName(bytes32 name)
             onlyOwner
    {
        eventName = name;
    }

    // function addTickets(bytes namePrefix, uint price, bytes group)
    // {

    // }

    // function removeGroup(bytes group) {

    // }

    // function blockGroup(bytes group)
    // {

    // }

    // function unblockGroup(bytes group)
    // {

    // }


    function addTicket(bytes32 ticketCode, uint price)
             onlyOwner
    {
        tickets[ticketCode] = Ticket({
        code: ticketCode,
        price: uint32(price),
        purchased: false
        });
    }


    function removeTicket(bytes32 ticketCode)
             onlyOwner
    {
        delete tickets[ticketCode];
    }


    function purchase(bytes32 ticketCode)
             payable
             returns(bool)
    {
        if (tickets[ticketCode].code != ticketCode) {
            revert();
        }
        var ticket = tickets[ticketCode];
        require(!ticket.purchased);

        value = msg.value;
        require(uint32(ticket.price) <= uint32(msg.value));

        ticket.purchased = true;
        sales[msg.sender] = ticket;
        tickets[ticketCode] = ticket;
        eventGross += msg.value;

        return ticket.purchased;
    }


    function withdraw()
             onlyOwner
    {
        msg.sender.transfer(eventGross);
        eventGross = 0;
    }
}
