script {
    use 0x1::Crowdfunding;
    use 0x1::Debug;

    fun main(campaign_owner: address) {
        let (target_amount, collected_amount, risk_level, active, description, start_date) = Crowdfunding::get_campaign_details(campaign_owner);
        
        Debug::print_u64(b"Target Amount: ", target_amount);
        Debug::print_u64(b"Collected Amount: ", collected_amount);
        Debug::print_u64(b"Risk Level: ", risk_level as u64); 
        Debug::print_bool(b"Active: ", active);
        Debug::print_vector_u8(b"Description: ", &description);
        Debug::print_u64(b"Start Date: ", start_date);
    }
}
