# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'opens the index page' do
    get bulletins_url

    assert_response :success
    assert_select 'h1', 'Bulletins'
    assert_select 'div' do |element|
      assert_select element, 'p', 2
    end
  end

  test 'opens the show page' do
    bulletin = bulletins(:bulletin_one)

    get bulletin_path(bulletin)

    assert_response :success
    assert_select 'ul' do |nav|
      assert_select nav, 'li', 2
    end
    assert_select 'h1', bulletin.title
    assert_select 'div', bulletin.body
  end
end
