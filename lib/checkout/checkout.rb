# interface to process user checkout

module PB
    class Checkout
        def initialize(pricing_rules)
            @pricing_rules = pricing_rules
            @total = 0
            @scanned_items = []
        end

        def total
            @total
        end

        def scanned_items
            @scanned_items
        end

        def pricing_rules
            @pricing_rules
        end

        # method to scan codes
        def scan(code)
            # get code price for scanned item
            price = get_code_price(code)

            # push scanned items unto @scanned_items array
            @scanned_items.push(code)

            # increase total
            @total = @total + price

            # both pricing rules require you to have 2 or more products
            # therefore lets start applying rules only if @scanned_items 
            # contain 2 or more.
            if @scanned_items.length >= 2
                @total = apply_pricing_rule_discount(@total, code)
            end
            
            @total
        end

        def apply_pricing_rule_discount(total, code)
            discounted_total = total
            # loop through @pricing_rules array and apply 
            # each rule in array to total
            @pricing_rules.each do | rule |
                if rule == "3_FOR_2"
                    discounted_total = apply_3_for_2_discount(discounted_total, code)
                elsif rule == "3_OR_MORE_TSHIRTS"
                    discounted_total = apply_3_or_more_discount(discounted_total,  code)
                end
            end

            discounted_total
        end

        def apply_3_for_2_discount(total, code)
            # apply discount to only DATA_VOUCHER code
            if code != "DATA_VOUCHER"
                return total
            end

            # check scanned items to see if item exists twice
            items = @scanned_items.select { |item| item === code}            
            # if there is 3 or more items with the selected code
            # that means the discount has already been applied 
            # no need to add any more discount
            if items.length >= 3
                return total
            end


            # if there is 2 items, the third item should be a discount
            if items.length == 2
                item_price = get_code_price(code)
                # apply discount
                total -= item_price
            end

            total
        end

        def apply_3_or_more_discount(total, code)
            new_total = 0
            # apply discount to only TSHIRT code
            if code != "TSHIRT"
                return total
            end

            items = @scanned_items.select { |item| item == code}
            # this discount should only be applied when theres
            # 3 or more TSHIRTS
            if items.length >= 3  
                # check if discount has not been applied to TSHIRTs
                # if so, get new total by subtracting total number of TSHIRTS
                # from total
                # else subtract 1 from total
                if items.length == 3
                    new_total = total - items.length
                else
                    new_total = total - 1
                end

                return new_total
            end

            total
        end

        def get_code_price(code)
            price = nil
            case code
            when "DATA_VOUCHER"
                price = 100.00
            when "TSHIRT"
                price = 10.00
            when "MUG"
                price = 7.50
            else
                price = 0
            end
        end
    end
end