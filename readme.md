In this smart contract, patient data is stored using the Patient struct, which includes fields for the patient's name, age, gender, EHR data, EMR data, and the address of the creator (patient).

The PatientDataStorage contract allows the following functionalities:

  *CreatePatientRecord: Allows the creation of a patient record by providing the patient's name, age, gender, EHR data, and EMR data. The patient's address is used as the key in the mapping to store the patient's data.
  
  *UpdateEHRData: Allows the patient to update their EHR data by providing the new EHR data.

  *UpdateEMRData: Allows the patient to update their EMR data by providing the new EMR data.
  
  *GetPatientData: Retrieves the patient's data (name, age, gender, EHR data, and EMR data) based on the patient's address.
  
  *The onlyPatient modifier ensures that only the patient associated with a particular address can perform certain actions, such as updating their EHR or EMR data.
  
  *Events are emitted for record creation, EHR data updates, and EMR data updates to track the changes in the patient's data.
  
  * Please note that this is a simplified example to demonstrate the basic structure of the smart contract. In practice, additional data validation, access control   mechanisms, and security considerations should be implemented to ensure the privacy and integrity of patient data.
