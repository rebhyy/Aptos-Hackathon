address 0x60ba1a70dd0e0e2d6bd121062bb7864ae07a243d2967c2dcc036155adc3cd056{
module TourathCoin {
    use std::signer;

    struct HeritageCoin has store, key {
        value: u64,
        metadata: CoinMetadata,
    }

    struct CoinMetadata has copy, drop, store {
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
    }

    public entry fun publish(sender: &signer) {
        let initial_value = 1000;  // Initial coin amount
        let metadata = CoinMetadata {
            name: b"Tourath Coin", // Byte string for vector<u8>
            symbol: b"THC", // Byte string for vector<u8>
            description: b"Used to support the maintenance and restoration of archaeological sites.", // Byte string for vector<u8>
        };

        let coin = HeritageCoin { value: initial_value, metadata };
        move_to(sender, coin);
    }

    public entry fun mint(sender: &signer, amount: u64) acquires HeritageCoin {
        let coin = borrow_global_mut<HeritageCoin>(signer::address_of(sender));
        coin.value = coin.value + amount;
    }

    public fun balance_of(account: address): u64 acquires HeritageCoin {
        let coin = borrow_global<HeritageCoin>(account);
        coin.value
    }

    public fun get_metadata(account: address): CoinMetadata acquires HeritageCoin {
        let coin = borrow_global<HeritageCoin>(account);
        coin.metadata
    }        
    




}
}
