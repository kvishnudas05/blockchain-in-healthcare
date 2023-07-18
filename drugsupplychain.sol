pragma solidity ^0.8.0;

contract DrugSupplyChain {
    
    struct Drug {
        uint256 batchNumber;
        string name;
        uint256 manufacturingDate;
        uint256 expiryDate;
        address manufacturer;
        address distributor;
        address retailer;
        bool isVerified;
    }
    
    mapping(uint256 => Drug) public drugs;
    
    event DrugManufactured(uint256 indexed batchNumber, string name, address indexed manufacturer);
    event DrugTransferred(uint256 indexed batchNumber, address indexed from, address indexed to);
    event DrugVerified(uint256 indexed batchNumber);
    
    modifier onlyManufacturer(uint256 _batchNumber) {
        require(msg.sender == drugs[_batchNumber].manufacturer, "Only the manufacturer can perform this action.");
        _;
    }
    
    modifier onlyDistributor(uint256 _batchNumber) {
        require(msg.sender == drugs[_batchNumber].distributor, "Only the distributor can perform this action.");
        _;
    }
    
    modifier onlyRetailer(uint256 _batchNumber) {
        require(msg.sender == drugs[_batchNumber].retailer, "Only the retailer can perform this action.");
        _;
    }
    
    function manufactureDrug(uint256 _batchNumber, string memory _name, uint256 _manufacturingDate, uint256 _expiryDate) public {
        require(drugs[_batchNumber].batchNumber == 0, "A drug with the same batch number already exists.");
        
        drugs[_batchNumber] = Drug(_batchNumber, _name, _manufacturingDate, _expiryDate, msg.sender, address(0), address(0), false);
        
        emit DrugManufactured(_batchNumber, _name, msg.sender);
    }
    
    function transferDrug(uint256 _batchNumber, address _to) public {
        require(drugs[_batchNumber].batchNumber != 0, "The drug with the specified batch number does not exist.");
        
        if (drugs[_batchNumber].distributor == address(0)) {
            drugs[_batchNumber].distributor = _to;
        } else if (drugs[_batchNumber].retailer == address(0)) {
            drugs[_batchNumber].retailer = _to;
        }
        
        emit DrugTransferred(_batchNumber, msg.sender, _to);
    }
    
    function verifyDrug(uint256 _batchNumber, uint256 _otp) public onlyRetailer(_batchNumber) {
        require(drugs[_batchNumber].batchNumber != 0, "The drug with the specified batch number does not exist.");
        require(!_isExpired(_batchNumber), "The drug has already expired.");
        
        // Perform OTP verification here
        
        drugs[_batchNumber].isVerified = true;
        
        emit DrugVerified(_batchNumber);
    }
    
    function _isExpired(uint256 _batchNumber) internal view returns (bool) {
        return block.timestamp >= drugs[_batchNumber].expiryDate;
    }
}
