module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def sign_up(credentials)
    visit signup_path
    fill_in('user_username', with:credentials[:user_username])
    fill_in('user_password', with:credentials[:user_password])
    fill_in('user_password_confirmation', with:credentials[:user_password_confirmation])
  end

end
