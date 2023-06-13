use starknet::ContractAddress;

#[abi]
trait IDiode {
    ///IERC721 functions
    fn is_approved_for_all(owner: ContractAddress, operator: ContractAddress) -> bool;
    fn get_approved(token_id: u256) -> ContractAddress;
    fn balance_of(account: ContractAddress) -> u256;
    fn owner_of(token_id: u256) -> ContractAddress;
    fn get_name() -> felt252;
    fn get_symbol() -> felt252;
    fn set_approval_for_all(operator: ContractAddress, approved: bool);
    fn approve(to: ContractAddress, token_id: u256);
    fn transfer_from(from: ContractAddress, to: ContractAddress, token_id: u256);

    ///Diode specific functions
    fn mint() -> u256;

}

#[contract]
mod Diode {
    use diode_new::erc721Base::ERC721Base;
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::ContractAddress;
    use starknet::contract_address::ContractAddressZeroable;
    use zeroable::Zeroable;
    use traits::Into;
    use traits::TryInto;
    use option::OptionTrait;
    use integer::BoundedInt;
    use debug::PrintTrait;  

    //impl DiodeImpl of IDiode {
    //    /// ERC721 impl
    //    fn get_name() -> felt252 {
    //        
    //
    //    }
    //
    //    /// Diode specific impl
    //}  

    #[constructor]
    fn constructor(name: felt252, symbol: felt252) {
        ERC721Base::initializer(name, symbol);
    }

    #[view]
    fn name() -> felt252 {
        ERC721Base::name()
    }

    #[external]
    fn mint() -> u256 {
        let sender_address: ContractAddress = get_caller_address();
        let tokenId = totalSupply::read();
        _mint(sender_address, tokenId);
        totalSupply::write(tokenId + 1.into());
        tokenId;
    }
} 