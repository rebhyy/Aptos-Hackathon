script {
    use 0x1::Crowdfunding;
    use aptos_framework::signer;

    fun main(account: &signer, campaign_owner: address, amount: u64) {
        Crowdfunding::contribute_and_reward(account, campaign_owner, amount);
    }
}
