require 'test_helper'

class GivenAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @given_answer = given_answers(:one)
  end

  test "should get index" do
    get given_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_given_answer_url
    assert_response :success
  end

  test "should create given_answer" do
    assert_difference('GivenAnswer.count') do
      post given_answers_url, params: { given_answer: { answer: @given_answer.answer, user_id: @given_answer.user_id } }
    end

    assert_redirected_to given_answer_url(GivenAnswer.last)
  end

  test "should show given_answer" do
    get given_answer_url(@given_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_given_answer_url(@given_answer)
    assert_response :success
  end

  test "should update given_answer" do
    patch given_answer_url(@given_answer), params: { given_answer: { answer: @given_answer.answer, user_id: @given_answer.user_id } }
    assert_redirected_to given_answer_url(@given_answer)
  end

  test "should destroy given_answer" do
    assert_difference('GivenAnswer.count', -1) do
      delete given_answer_url(@given_answer)
    end

    assert_redirected_to given_answers_url
  end
end
