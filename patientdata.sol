pragma solidity ^0.8.0;

contract PatientDataStorage {
    
    struct Patient {
        string name;
        uint256 age;
        string gender;
        string ehrData;
        string emrData;
        address creator;
    }
    
    mapping(address => Patient) public patients;
    
    event PatientRecordCreated(address indexed patientAddress, string name, address creator);
    event EHRDataUpdated(address indexed patientAddress, string ehrData);
    event EMRDataUpdated(address indexed patientAddress, string emrData);
    
    modifier onlyPatient(address _patientAddress) {
        require(msg.sender == _patientAddress, "Only the patient can perform this action.");
        _;
    }
    
    function createPatientRecord(string memory _name, uint256 _age, string memory _gender, string memory _ehrData, string memory _emrData) public {
        require(bytes(_name).length > 0, "Patient name cannot be empty.");
        require(_age > 0, "Patient age must be greater than zero.");
        
        patients[msg.sender] = Patient(_name, _age, _gender, _ehrData, _emrData, msg.sender);
        
        emit PatientRecordCreated(msg.sender, _name, msg.sender);
    }
    
    function updateEHRData(string memory _ehrData) public onlyPatient(msg.sender) {
        patients[msg.sender].ehrData = _ehrData;
        
        emit EHRDataUpdated(msg.sender, _ehrData);
    }
    
    function updateEMRData(string memory _emrData) public onlyPatient(msg.sender) {
        patients[msg.sender].emrData = _emrData;
        
        emit EMRDataUpdated(msg.sender, _emrData);
    }
    
    function getPatientData(address _patientAddress) public view returns (string memory, uint256, string memory, string memory, string memory) {
        require(_patientAddress != address(0), "Invalid patient address.");
        
        Patient memory patient = patients[_patientAddress];
        
        return (patient.name, patient.age, patient.gender, patient.ehrData, patient.emrData);
    }
}
