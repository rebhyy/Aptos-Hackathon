script {
    use 0x1::Crowdfunding;

    fun main(campaign_owner: address) {
        let details = Crowdfunding::get_campaign_details(campaign_owner);
    }
}
