describe PB do

    let(:pricing_rules) {["3_FOR_2", "3_OR_MORE_TSHIRTS"]}
    let(:co) { PB::Checkout.new(pricing_rules)}

    it "should get the right total for 'DATA_VOUCHER' code" do
        co.scan("DATA_VOUCHER")
        total = co.total()
        expect(total).to eq(100)
    end

    it "should get the right total for 'TSHIRT' code" do
        co.scan("TSHIRT")
        total = co.total()
        expect(total).to eq(10)
    end

    it "should get the right total for 'MUG' code" do
        co.scan("MUG")
        total = co.total()
        expect(total).to eq(7.5)
    end

    it "should apply 3_FOR_2 discount correctly and only on DATA_VOUCHER code" do
        co.scan("DATA_VOUCHER")
        co.scan("DATA_VOUCHER")
        co.scan("DATA_VOUCHER")
        co.scan("MUG")
        expect(co.total()).to eq(207.5)
    end

    it "should apply 3_OR_MORE_TSHIRTS discount correctly and only on TSHIRT code" do
        co.scan("TSHIRT")
        co.scan("TSHIRT")
        co.scan("TSHIRT")
        co.scan("TSHIRT")
        co.scan("MUG")
        expect(co.total()).to eq(43.5)
    end
end