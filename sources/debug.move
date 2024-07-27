module 0x1::Debug {
    use std::debug;

    public fun print_u64(label: &vector<u8>, value: u64) {
        debug::print(&Vector::concat(label, &b" ".to_vec()));
        debug::print(&u64::to_string(value).to_vec());
    }

    public fun print_bool(label: &vector<u8>, value: bool) {
        debug::print(&Vector::concat(label, &b" ".to_vec()));
        debug::print(&if value { b"true".to_vec() } else { b"false".to_vec() });
    }

    public fun print_vector_u8(label: &vector<u8>, value: &vector<u8>) {
        debug::print(&Vector::concat(label, &b" ".to_vec()));
        debug::print(value);
    }
}
