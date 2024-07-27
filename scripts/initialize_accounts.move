script {
    use 0x1::Crowdfunding;
    use 0x1::CIDStorage;
    use 0x60ba1a70dd0e0e2d6bd121062bb7864ae07a243d2967c2dcc036155adc3cd056::TourathCoin;
    use aptos_framework::signer;

    fun main(account: &signer) {
        Crowdfunding::initialize(account);
        CIDStorage::initialize(account);
        TourathCoin::publish(account);
    }
}
