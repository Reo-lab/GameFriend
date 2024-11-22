# frozen_string_literal: true

RSpec.describe 'URL Access', type: :request do
  let(:user) { create(:user) }

  before do
    user.skip_confirmation! # メール確認をスキップ
    user.save!
    sign_in user
  end

  it 'should be in test environment' do
    expect(Rails.env.test?).to be true
  end

  it 'chatrooms index page is accessible' do
    get chatrooms_path
    expect(response).to be_successful
  end

  it 'chatrooms show page is accessible' do
    chatroom = create(:chatroom)
    get chatroom_path(chatroom)
    expect(response).to be_successful
  end

  it 'gametitles index page is accessible' do
    get gametitles_path
    expect(response).to be_successful
  end

  it 'setups index page is accessible' do
    get setups_path
    expect(response).to be_successful
  end

  it 'boards index page is accessible' do
    get boards_path
    expect(response).to be_successful
  end

  it 'boards_requests index page is accessible' do
    get boards_requests_path
    expect(response).to be_successful
  end

  it 'users index page is accessible' do
    get users_path
    expect(response).to be_successful
  end

  it 'users show page is accessible' do
    get user_path(user)
    expect(response).to be_successful
  end

  it 'users_slides index page is accessible' do
    get user_users_slides_path(user)
    expect(response).to be_successful
  end

  it 'slide_images index page is accessible' do
    get slide_images_path
    expect(response).to be_successful
  end

  it 'tops index page is accessible' do
    get tops_path
    expect(response).to be_successful
  end

  it 'helper_images index page is accessible' do
    get helper_images_path
    expect(response).to be_successful
  end
end
