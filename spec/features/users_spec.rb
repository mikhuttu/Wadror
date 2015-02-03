require 'rails_helper'

describe "User" do
 
  describe "who has signed up" do
    before :each do
      FactoryGirl.create :user
    end

    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      sign_up(user_username:'Brian', user_password:'Secret55', 
              user_password_confirmation:'Secret55')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end

  it "has list of ratings in its page" do
    user = FactoryGirl.create :user
    user2 = FactoryGirl.create :user, name:"Erkki"

    r1 = FactoryGirl.create :rating
    r2 = FactoryGirl.create :rating, score:27
    r3 = FactoryGirl.create :rating, score:6

    user.ratings << r1
    user.ratings << r2
    user2.ratings << r3

    visit user_path(user)

    expect(page).to have_content 'has made 2 ratings'
    expect(page).to have_content 'score: 27'
  end

end
