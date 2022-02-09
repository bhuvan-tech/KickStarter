pragma solidity ^0.4.17;

contract CampaignFactory{
    address[] public deployedCampaigns;

    function createCampaign(uint minimum) public{
        address newCampaign= new Campaign(minimum, msg.sender);  //creates new instance of campaign
        deployedCampaigns.push(newCampaign);
    }

    function getDeployedCampaign() public view returns(address[]){
        return deployedCampaigns;
    }
}
contract Campaign{
    //request only manager can call
    struct Request{
        string description;
        uint value;
        address recipient;
        bool complete;
        mapping(address => bool) approvals;
        uint approvalCount;

    }

    address public manager;
    uint256 public minimumContribution;
    Request[] public requests;
    mapping(address => bool) public approvers;
    uint public approversCount;

    modifier onlyManagerCanCall(){
        require(msg.sender == manager);
        _;
    }

    function Campaign(uint minimumEth, address creater) public{
        manager = creater;
        minimumContribution = minimumEth;
    }

    function contribute() public payable{
        require(msg.value > minimumContribution);
        
        approvers[msg.sender] = true;
        approversCount++;   //count contributed people
    }

    function createRequest(string des, uint val, address recipient) public onlyManagerCanCall{
        Request memory newRequest = Request({
            description : des,
            value : val,
            recipient : recipient,
            complete : false,
            approvalCount: 0 
        });

       //other way to initialise struct
       // Request(description, value, recipient, false);

        requests.push(newRequest);
    }

    //pass index to approve specific request 
    function approveRequest(uint index) public{
        Request storage request = requests[index];
    
        require(approvers[msg.sender]); //so that they are a contibuter
        require(!request.approvals[msg.sender]); //let people vote only if they hv not already voted

        request.approvals[msg.sender] = true;
        request.approvalCount++;        //approvalcount
    } 
    
    function finalizeRequest(uint index) public onlyManagerCanCall{
        Request storage request = requests[index];
        
        require(request.approvalCount > (approversCount / 2)); //min 50% yes vote
        require(!request.complete);     //not yet complete
        
        request.recipient.transfer(request.value);

        request.complete=true;
    }
    
}