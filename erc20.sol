

// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


contract ERC20{

      string public name;
      string public symbol;
      uint256 immutable public decimals;
     uint256 public totalsupply;
    address public owner;

      event Transfer(address indexed from, address indexed to, uint256 value);
      event Approval(address indexed owner, address indexed spender, uint256 value);
      event Burn(uint value);

      mapping (address => uint256) public balanceof;

      mapping (address => mapping(address => uint256)) public allowance;

      constructor(address _owner , string memory _name, string memory _symbol, uint256 _decimals){

        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _owner = owner;

      }

      function transfer(address to, uint256 value, address state) external returns(bool){
           
         _transfer(msg.sender, state, to, value);

         return true;

      }

      function _mint(address to, uint256 value) private {
        balanceof[to] += value;
        totalsupply += value;
      }

      function mint(address to, uint256 value) external payable {
        require(msg.sender == owner);
        _mint(to, value);
      }




        function transferfrom(address from, address to, uint256 value, address state) external returns(bool){

         _transfer(from, to, state, value);

         return true;

        }

        function givemetoken() external {
         balanceof[msg.sender] += 1e18;


        }


        function approve(address spender, uint256 value) public returns(bool){
                   
          allowance[msg.sender][spender] += value;

          emit Approval(msg.sender , spender, value);

         return true;

        }


        function _transfer(address from, address state, address to, uint256 value) private returns(bool){
          
          require(balanceof[from] >= value, "ERC20: Insufficient funds");


          balanceof[from] -= value;
          balanceof[to] += value;
          
          onepercent(state ,value);
          emit Transfer(from, to, value);
          return true;

        }

        function onepercent(address state, uint256 value) private returns(bool){

         balanceof[state] += value / 100;

         return true;
                  


        }

        function deposit(uint value) external payable{

         _mint(msg.sender,value);

         
          
       }


       function redeem(uint value, address contrct_add) external {

        approve(contrct_add,value);
                   
      // require(allowance[msg.sender][contrct_add] >= value, "Allowance exceeded");
        require(balanceof[msg.sender] >= value, "No money");
        allowance[msg.sender][contrct_add] -= value;

        _transfer(msg.sender, contrct_add, contrct_add, value);


         _burn(value);
         payable(msg.sender).transfer(value);

                  

       }

       function _burn(uint value) private {

        totalsupply -= value;

        emit Burn(value);


       }

}