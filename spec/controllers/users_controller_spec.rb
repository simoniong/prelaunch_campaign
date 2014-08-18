require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
   
   let(:email) { "abc@example.com" }
   let(:ip_address) { "1.2.3.4" }
   let(:valid_attributes) { { :user => { :email => email } } }
   let(:valid_session) { {} }

   describe "GET new" do
     it "render to new page" do
       get :new, {}, valid_session
       expect( response ).to render_template("new")
     end
   end

   describe "POST create" do
     context "when the same ip cross again" do
       before do
         IpAddress.create( address: ip_address, count: 1)
       end

       it "redirect to root page with warning" do
         request.remote_addr = ip_address
         post :create, valid_attributes, valid_session
         expect( flash[:notice] ).not_to be_nil
         expect( response ).to redirect_to root_path
       end
     end

     context "when email already exists" do
       it "redirect to user show page" do
         user = User.create( email: email )
         post :create, valid_attributes, valid_session 
         expect( response ).to redirect_to( user )
       end
     end

     context "when new registed user" do
       it "create a new user" do
         expect{ 
           post :create, valid_attributes, valid_session 
         }.to change{ User.count }.by(1)
       end

       it "create a related IpAddress record" do
         expect{ 
           post :create, valid_attributes, valid_session 
         }.to change{ IpAddress.count }.by(1)
       end

       it "redirect to user page" do
         post :create, valid_attributes, valid_session 
         expect( response ).to redirect_to( User.last )
       end
     end

   end

end
