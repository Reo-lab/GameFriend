# frozen_string_literal: true

RSpec.describe 'Environment check' do
  it 'should be in test environment' do
    expect(Rails.env.test?).to be true
  end
end
