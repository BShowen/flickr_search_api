require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get root_url
    assert_response :success
  end

  test "flash response" do 
    get root_url

    # flash should render with blank search
    post root_url, params: { search: { username: ' '}}
    assert_not flash.empty?

    # flash should render with a search for a user who has photos
    post root_url, params: { search: { username: 'bradleh2' }}
    assert_not flash.empty?

    # flash should render with a search for a user who doesnt have photos
    post root_url, params: { search: { username: 'sir'}}
    assert_not flash.empty?

    # flash should render with a search for a user who doesnt exits
    post root_url, params: { search: { username: 'foo-woo-bar-baz' }}
    assert_not flash.empty?
  end

  test "photo rendering and links" do
    post root_url, params: { search: { username: 'bradleh2' }}
    assert_not flash.empty?
    # assert_select 'div.d-flex>div.py-2', minimum: 1 # this is the same as doing the next three lines of code. 
    assert_select 'div.d-flex' do
      assert_select 'div.py-2', minimum: 1 do 
        # test for presence of a link
        assert_select 'a', minimum: 1
      end
    end
  end

end
