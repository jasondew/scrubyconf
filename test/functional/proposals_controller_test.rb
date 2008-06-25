require 'test_helper'

class ProposalsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:proposals)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_proposal
    assert_difference('Proposal.count') do
      post :create, :proposal => { }
    end

    assert_redirected_to proposal_path(assigns(:proposal))
  end

  def test_should_show_proposal
    get :show, :id => proposals(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => proposals(:one).id
    assert_response :success
  end

  def test_should_update_proposal
    put :update, :id => proposals(:one).id, :proposal => { }
    assert_redirected_to proposal_path(assigns(:proposal))
  end

  def test_should_destroy_proposal
    assert_difference('Proposal.count', -1) do
      delete :destroy, :id => proposals(:one).id
    end

    assert_redirected_to proposals_path
  end
end
