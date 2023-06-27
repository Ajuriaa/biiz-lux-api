module DeviseHelper
  def login_user(user = nil)
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = user || create(:user)
      sign_in @current_user
    end
  end
end
