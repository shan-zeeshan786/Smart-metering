pragma solidity ^0.8.0;
 
contract SmartMeter {
     //set owner
  address public owner;
 constructor ()  {
       owner = msg.sender;
   }
   function getOwner()public view returns(address){
    return owner;
   }
    //users details
    struct User {
        string id;
        string name;
        string email;
        string password;
        string meterReading;
        string currentReading;
        string address_H;
        string phone;
    }
    uint public users_count=0;
     
 

    //To map id with users data
    mapping(string => User) private users;
    string[] listofusers;

    // signup
    function Adduser(string memory _id,string memory _name,string memory _email,string memory _pass, string memory _phone,string memory _address_h) public {
        //  uint id=generateRandomNumber();
         users[_id].id=_id;
         users[_id].name=_name;
         users[_id].email=_email;
         users[_id].password=_pass;
         users[_id].meterReading="0";
         users[_id].currentReading="0";
         users[_id].phone=_phone;
         users[_id].address_H=_address_h;
         listofusers.push(_id);
         users_count++;
        
    }
    function checkbymobile(string memory _user)public view returns(string memory){
        for(uint i=0;i<listofusers.length;i++){
            if(keccak256(abi.encodePacked(users[listofusers[i]].phone)) == keccak256(abi.encodePacked(_user))){
                return listofusers[i];
             }
       }
    return "no";
    }
    // update Reading of user
    function updReading(string memory _id,string memory _reading)public{
        users[_id].currentReading=_reading;
    }
    // Transfer fund;
    function transfer()public payable{
        
    }
    function settle(string memory _id)public{
        users[_id].meterReading=users[_id].currentReading;
        users[_id].currentReading='0';
    }
      //// Check for existance of user by id////
    function checkbyid(string memory _id)public view returns(bool){
        string memory a=users[_id].id;
         if(keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(_id)))return true;
         
          return false;
    }
    /// dearch using id////
    function getUser(string memory id) public view returns (string memory, string memory,string memory,string memory,string memory, string memory ) {
         if(checkbyid(id)==false){
         return("no","no","no","no","no","no");
         }
        User memory user = users[id];
        return (user.name,user.email, user.meterReading, user.currentReading,user.address_H,user.phone);
    }
    /// For login using email and password///
    function get(string memory _em,string memory _pas ) public view returns(string memory){
         uint i=0;
         for(;i<listofusers.length;i++){
           User memory user=users[listofusers[i]];
            if(keccak256(abi.encodePacked(user.email)) == keccak256(abi.encodePacked(_em)) && keccak256(abi.encodePacked(user.password)) == keccak256(abi.encodePacked(_pas))){
                return user.id;
            }

        
      }
      return "no";
    }
    function withdraw(uint256 withdrawAmount) external {
        require(
            msg.sender == owner,
            "Cannot withdraw more than 2 ether"
        );
        payable(msg.sender).transfer(withdrawAmount);
    } 
     
}
