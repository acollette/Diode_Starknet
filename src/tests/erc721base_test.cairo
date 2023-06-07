use starknet::syscalls::deploy_syscall;
use starknet::class_hash::Felt252TryIntoClassHash;
use starknet::contract_address::contract_address_const;
use starknet::ContractAddress;
use starknet::testing;
use starknet::get_contract_address;
use traits::Into;
use traits::TryInto;
use option::OptionTrait;
use result::ResultTrait;
use array::ArrayTrait;
use debug::PrintTrait;

use diode_new::erc721Base::ERC721Base;

fn setup() -> (ContractAddress,) {
    // Set up.

    // Deploy mock token.

    let alice = contract_address_const::<0x123456789>();

    let mut calldata = ArrayTrait::new();
    let name = 'NFT Contract';
    let symbol = 'NFT';
    calldata.append(name);
    calldata.append(symbol);

    testing::set_contract_address(alice);
    let (token_address, _) = deploy_syscall(
        ERC721Base::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
    )
        .unwrap();

    //let token = IMockERC20Dispatcher { contract_address: token_address };
    //let vault = IERC4626Dispatcher { contract_address: vault_address };

    (token_address,)
}