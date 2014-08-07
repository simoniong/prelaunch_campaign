require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:email) { "abc@example.com" }

  context "instance methods" do
    subject { described_class.new }
    it "respond to email" do
      expect(subject).to respond_to :email 
    end

    it "respond to referral_code" do
      expect(subject).to respond_to :referral_code
    end

    it "respond to referral_id" do
      expect(subject).to respond_to :referral_id
    end

    it "respond to status" do
      expect(subject).to respond_to :status
    end
  end

  context 'validation' do
    context 'email' do
      context 'when email is valid' do
        it 'to be valid' do
          expect( described_class.new( :email => email ) ).to be_valid
        end
      end

      context 'when email is invalid' do
        it 'to be invalid when email is nil' do
          expect( described_class.new( :email => nil ) ).to be_invalid
        end

        it 'to be invalid when email is empty string' do
          expect( described_class.new( :email => '' ) ).to be_invalid
        end

        it 'to be invalid when email is invalid format' do
          expect( described_class.new( :email => 'abcd' ) ).to be_invalid
        end

        it 'to be invalid when email is already in database' do
          described_class.create( :email => email )
          expect( described_class.new( :email => email ) ).to be_invalid
        end
      end
    end

    context 'status' do
      it 'to be invalid when status in out of scope' do
        expect( described_class.new(:email => email, :status => 'abc') ).to be_invalid
      end

      it 'to be valid when status in the scope list' do
        expect( described_class.new(:email => email, :status => 'pending') ).to be_valid
        expect( described_class.new(:email => email, :status => 'subscribed') ).to be_valid
      end
    end
  end

  context 'setup referral code' do
    it 'setup referral code after create' do
      instance = described_class.create( :email => email ) 
      expect( instance.referral_code ).not_to be_nil
    end
  end
end
