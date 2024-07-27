address 0x1 {
module Voting {
    use aptos_framework::coin::{Coin, deposit, withdraw_from};
    use aptos_framework::signer;
    use aptos_framework::map::Map;

    struct Proposal has key {
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        active: bool,
    }

    struct Proposals has key {
        proposals: Map::Map<u64, Proposal>,
        next_id: u64,
    }

    public fun initialize(account: &signer) {
        let proposals = Proposals {
            proposals: Map::empty(),
            next_id: 1,
        };
        move_to(account, proposals);
    }

    public fun create_proposal(account: &signer, description: vector<u8>) acquires Proposals {
        let mut proposals = borrow_global_mut<Proposals>(signer::address_of(account));
        let proposal = Proposal {
            description,
            votes_for: 0,
            votes_against: 0,
            active: true,
        };
        Map::add(&mut proposals.proposals, proposals.next_id, proposal);
        proposals.next_id = proposals.next_id + 1;
    }

    public fun vote(account: &signer, proposal_id: u64, support: bool) acquires Proposals {
        let mut proposals = borrow_global_mut<Proposals>(signer::address_of(account));
        let proposal = Map::borrow_mut(&mut proposals.proposals, &proposal_id).unwrap();
        if support {
            proposal.votes_for = proposal.votes_for + 1;
        } else {
            proposal.votes_against = proposal.votes_against + 1;
        }
    }

    public fun get_proposal_details(proposal_id: u64): (vector<u8>, u64, u64, bool) acquires Proposals {
        let proposals = borrow_global<Proposals>(signer::address_of(proposal_id));
        let proposal = Map::borrow(&proposals.proposals, &proposal_id).unwrap();
        (
            proposal.description,
            proposal.votes_for,
            proposal.votes_against,
            proposal.active
        )
    }
}
}
