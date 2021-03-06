require File.dirname(__FILE__) + '/../test_helper'

class StealthControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    user = User.last
    user.stealth_allowed = true
    user.save!

    @request.session[:user_id] = user.id
  end

  def test_toggle_enables_stealth_mode
    put :toggle
    assert_response :success
    assert RedmineStealth::Stealth.cloaked?
  end
end
