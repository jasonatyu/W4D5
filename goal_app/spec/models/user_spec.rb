require 'rails_helper'

RSpec.describe User, type: :model do
  #validations
  describe "Validations" do 
    context "checks presence of username, password_digest, and session_token" do
      subject(:user) { FactoryBot.build(:user) }
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_presence_of(:session_token) }
    end

    context "length of password" do
      it { validate_length_of(:password).is_at_least(6) }
    end
    
    context "ensure uniqueness on certain parameters" do
      it "should enforce uniqueness constraint on username" do 
        user_jon = FactoryBot.create(:user)
        user_jon_2 = FactoryBot.build(:user, username: user_jon.username)
        expect { user_jon_2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "should enforce uniqueness constraint on session token" do 
        user_jon = FactoryBot.create(:user)
        user_jon_2 = FactoryBot.build(:user, session_token: user_jon.session_token)
        expect { user_jon_2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end 
  #associations
  describe "Validations" do 

  end

  #methods 
  describe "::generate_session_token" do 
    it "generates a valid session token" do 
      expect(User.generate_session_token).to_not be_nil
    end 

    it "generates random valid session tokens" do 
      session_token = User.generate_session_token
      expect(User.generate_session_token).to_not eq(session_token)
    end

  end 

  describe "::find_by_credentials" do 
    subject(:user) { FactoryBot.create(:user) }
    
    it "returns nil if user is not found" do 
      expect(User.find_by_credentials("harry_potter", user.password)).to be_nil
    end 

    it "returns nil if password is incorrect for valid user" do 
      expect(User.find_by_credentials(user.username, "password123")).to be_nil
    end

     it "returns the user if valid credentials provided" do 
      # debugger
      expect(User.find_by_credentials(user.username, user.password)).to_not be_nil
    end
  end 

  describe "#password=" do 
    subject(:user) { FactoryBot.create(:user) }
    
    it "stores the password" do 
      expect(user.password).to_not be_nil
    end
    
    it "creates a new password_digest" do 
      expect(user.password_digest).to_not be_nil
    end
    
    it "does not persist the password to the database" do 
      expect(User.find_by(username: user.username).password).to be_nil
    end
  end 
  
  describe "#is_password?" do 
    subject(:user) { FactoryBot.create(:user) }
    it "returns true if given password matches BCrypt's is_password?" do 
      expect(BCrypt::Password.new(user.password_digest).is_password?(user.password)).to be true
    end

  end

end
