require 'rails_helper'
RSpec.describe 'Create New Bulk Discount' do 
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

  
    @discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percentage: 30, quantity_threshold: 30, merchant_id: @merchant1.id)
  end

  describe 'US 2 Discount Create' do 
      it 'when visiting b.discout index, i see link to create a new discount' do

        visit merchant_bulk_discounts_path(@merchant1.id)

        expect(page).to have_link("Add New Discount")

        click_link("Add New Discount")

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1.id))
      end

      it 'when I go to the new page I see a form to add a new bulk discount' do 

        visit new_merchant_bulk_discount_path(@merchant1.id)
    
        expect(page).to have_content("Fill out discount information")
        expect(page).to have_content("Percentage")
        expect(page).to have_content("Quantity threshold")
        expect(page).to_not have_content("New Merchant name:")
      end

      it 'After valid information is put in, visitor is redirected back to bulk discount index
            after submitting new discount. I am able to see new discount listed on b.discount index page' do 

        visit new_merchant_bulk_discount_path(@merchant1.id)

        fill_in("Percentage", with: 50)
        fill_in("Quantity threshold", with: 50)

        click_button("Submit") 

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1.id))
        
        expect(page).to have_content("Percentage: 50%")
        expect(page).to have_content("Min Qnty: 50")
    
    end 
  end
end