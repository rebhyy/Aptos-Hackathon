script {
    use 0x1::Crowdfunding;
    use aptos_framework::signer;

    fun main(account: &signer, target: u64, risk: u8) {
        Crowdfunding::start_campaign(account, target, risk);
    }
}
