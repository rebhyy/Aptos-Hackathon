address 0x1 {
module ReputationSystem {
    use aptos_framework::coin;
    use aptos_framework::signer;
    use aptos_framework::map::Map;

    struct UserReputation has key {
        reputation: u64,
    }

    struct ReputationMap has key {
        reputations: Map::Map<address, UserReputation>,
    }

    public fun initialize(account: &signer) {
        let reputations = ReputationMap {
            reputations: Map::empty(),
        };
        move_to(account, reputations);
    }

    public fun add_reputation(account: &signer, user: address, amount: u64) acquires ReputationMap {
        let mut reputations = borrow_global_mut<ReputationMap>(signer::address_of(account));
        let reputation = Map::borrow_mut(&mut reputations.reputations, &user).unwrap_or_default();
        reputation.reputation = reputation.reputation + amount;
        Map::add(&mut reputations.reputations, user, reputation);
    }

    public fun get_reputation(user: address): u64 acquires ReputationMap {
        let reputations = borrow_global<ReputationMap>(signer::address_of(user));
        let reputation = Map::borrow(&reputations.reputations, &user).unwrap();
        reputation.reputation
    }
}
}
