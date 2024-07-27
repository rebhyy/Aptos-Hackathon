script {
    use 0x1::CIDStorage;

    fun main(account_addr: address) {
        let cid = CIDStorage::get_cid(account_addr);
    }
}
