require 'rails_helper'

RSpec.feature '四則演算' do
  scenario '1 + 1 は 2 になること' do
    expect(1 + 1).to eq 2
  end
  scenario '10 - 1 は 9 になること' do
    expect(10 - 1).to eq 9
  end
end