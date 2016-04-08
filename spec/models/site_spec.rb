require 'rails_helper'

RSpec.describe Site, type: :model do
  describe 'validations' do
    subject { site }
    let(:site) { build :site, name: name, name_with_option: name_with_option, name_with_reserved_name_false: name_with_reserved_name_false }
    let(:name)                          { 'web' }
    let(:name_with_option)              { 'web' }
    let(:name_with_reserved_name_false) { 'web' }

    describe 'name' do

      context 'when name is nil without allow_nil option' do
        let(:name) { nil }
        it { is_expected.to_not be_valid }
      end
      context 'when name_with_option is nil with allow_nil option' do
        let(:name_with_option) { nil }
        it { is_expected.to be_valid }
      end
      context 'when name is blank without allow_blank option' do
        let(:name) { '' }
        it { is_expected.to_not be_valid }
      end
      context 'when name_with_option is blank with allow_blank option' do
        let(:name_with_option) { '' }
        it { is_expected.to be_valid }
      end

      context 'when name is default reserved name' do
        let(:name) { 'www' }
        it { is_expected.to_not be_valid }
      end
      context 'when name is default reserved name with reserved name option' do
        let(:name_with_option) { 'www' }
        it { is_expected.to be_valid }
      end
      context 'when name is reserved name with reserved name option' do
        let(:name_with_option) { 'blog' }
        it { is_expected.to_not be_valid }
      end
      context 'when name is default reserved name with reserved name option false' do
        let(:name_with_reserved_name_false) { 'www' }
        it { is_expected.to be_valid }
      end

      context 'when name is 2 characters' do
        let(:name) { 'a' * 2 }
        it { is_expected.to_not be_valid }
      end
      context 'when name is 3 characters' do
        let(:name) { 'a' * 3 }
        it { is_expected.to be_valid }
      end
      context 'when name is 63 characters' do
        let(:name) { 'a' * 63 }
        it { is_expected.to be_valid }
      end
      context 'when name is 64 characters' do
        let(:name) { 'a' * 64 }
        it { is_expected.to_not be_valid }
      end

      context 'when name includes numbers' do
        let(:name) { '000' }
        it { is_expected.to be_valid }
      end
      context 'when name includes letters in upper case' do
        let(:name) { 'AAA' }
        it { is_expected.to be_valid }
      end
      context 'when name includes letters in lower case' do
        let(:name) { 'aaa' }
        it { is_expected.to be_valid }
      end
      context 'when name includes -' do
        let(:name) { 'a-a' }
        it { is_expected.to be_valid }
      end
      context 'when name includes $' do
        let(:name) { 'w$w' }
        it { is_expected.to_not be_valid }
      end
      context 'when name includes .' do
        let(:name) { 'w.w' }
        it { is_expected.to_not be_valid }
      end
      context 'when name includes ;' do
        let(:name) { 'w;w' }
        it { is_expected.to_not be_valid }
      end

      context 'when name starts with -' do
        let(:name) { '-ww' }
        it { is_expected.to_not be_valid }
      end
      context 'when name ends with -' do
        let(:name) { 'ww-' }
        it { is_expected.to_not be_valid }
      end
    end
  end
end
