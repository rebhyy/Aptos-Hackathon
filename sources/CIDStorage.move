address 0x1 {
module CIDStorage {
    use aptos_framework::map::Map;

    struct CIDMap has key {

         // for less cost; map model addresses to their IPFS CIDs stored as byte vectors
        cids: Map::Map<address, vector<u8>>,
    }

    // Initializes the CID storage for a user
    public fun initialize(account: &signer) {
        let cid_map = CIDMap {
            cids: Map::empty(),
        };
        move_to(account, cid_map);
    }

    // Adds or updates a CID for the model
    public fun add_cid(account: &signer, cid: vector<u8>) acquires CIDMap {
        let cid_map = borrow_global_mut<CIDMap>(signer::address_of(account));
        Map::add(&mut cid_map.cids, signer::address_of(account), cid);
    }

    // Retrieves a CID for a specific model
    public fun get_cid(account_addr: address): vector<u8> acquires CIDMap {
        let cid_map = borrow_global<CIDMap>(account_addr);
        *Map::get(&cid_map.cids, account_addr).unwrap()
    }
}
}
