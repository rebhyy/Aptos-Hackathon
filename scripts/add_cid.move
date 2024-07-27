script {
    use 0x1::CIDStorage;
    use aptos_framework::signer;

    fun main(account: &signer, cid: vector<u8>) {
        CIDStorage::add_cid(account, cid);
    }
}
