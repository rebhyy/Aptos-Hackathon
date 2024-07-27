address 0x1 {
module Crowdfunding {
    use aptos_framework::coin::{Coin, deposit, withdraw_from};
    use aptos_framework::signer;
    use aptos_framework::map::Map;

    struct Campaign has key {
        target_amount: u64,
        collected_amount: u64,
        risk_level: u8,
        active: bool,
    }

    struct Campaigns has key {
        campaigns: Map::Map<address, Campaign>,
    }

    public fun initialize(account: &signer) {
        let campaigns = Campaigns {
            campaigns: Map::empty(),
        };
        move_to(account, campaigns);
    }

    // Function to start a new campaign based on AI risk assessment
    public fun start_campaign(account: &signer, target: u64, risk: u8) {
        let campaigns = borrow_global_mut<Campaigns>(signer::address_of(account));
        let campaign = Campaign {
            target_amount: target,
            collected_amount: 0,
            risk_level: risk,
            active: true,
        };
        Map::add(&mut campaigns.campaigns, signer::address_of(account), campaign);
    }

    // Function to contribute to a specific campaign
    public fun contribute_and_reward(account: &signer, campaign_owner: address, amount: u64) acquires Campaigns {
            let mut campaigns = borrow_global_mut<Campaigns>(campaign_owner);
        let mut campaign = Map::borrow_mut(&mut campaigns.campaigns, &campaign_owner).unwrap();
        assert!(campaign.active, 401, "Campaign is not active");

        let coin = withdraw_from(account, amount);
        deposit(&mut campaign.collected_amount, coin);



    let reward = calculate_reward(amount);
    TourathCoin::mint_to(account, reward);
        
    }


    public fun calculate_reward(amount: u64): u64 {
    if (amount >= 5000) {
        700
    } else if (amount >= 1000) {
        120
    } else if (amount >= 500) {
        50
    } else {
        0
    }
    }

    // Function to check campaign progress and potentially close it
    public fun check_and_close_campaign(campaign_owner: address) acquires Campaigns {
        let mut campaigns = borrow_global_mut<Campaigns>(campaign_owner);
        let mut campaign = Map::borrow_mut(&mut campaigns.campaigns, &campaign_owner).unwrap();

        if campaign.collected_amount >= campaign.target_amount {
            campaign.active = false;
        }
    }

    // Retrieve details about a specific campaign
    public fun get_campaign_details(campaign_owner: address): (u64, u64, u8, bool, vector<u8>, u64) acquires Campaigns {
        let campaigns = borrow_global<Campaigns>(campaign_owner);
        let campaign = Map::borrow(&campaigns.campaigns, &campaign_owner).unwrap();
        (
            campaign.target_amount,
            campaign.collected_amount,
            campaign.risk_level,
            campaign.active,
            campaign.description,
            campaign.start_date
        )
    }
}
}
