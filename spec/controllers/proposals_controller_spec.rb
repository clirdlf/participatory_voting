# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do
  login_user

  let(:valid_attributes) do
    {
      author: 'Fake Author',
      title: 'Fake Title',
      abstract: 'Fake Abstract',
      contribution_type: 'Fake ContributionType',
      contribution_format: 'Fake ContributionFormat'
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Proposal.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end

    it 'assigns @proposals' do
      proposal = FactoryBot.create(:proposal)
      get :index
      expect(assigns(:proposals)).to eq([proposal])
    end
  end

  describe 'GET #stats' do
    it 'returns a success response' do
      FactoryBot.create(:proposal)
      get :stats, params: {}
      expect(response).to be_successful
    end
  end

  describe '#like' do
    before :each do
      FactoryBot.create(:proposal)
    end

    describe 'voting for a proposal' do
      it 'calls the #like method of the proposal via put' do
        # put :like, :params => { :proposal => :proposal }
        # expect { proposal }.to receive(:vote).with(1)
      end

      it 'calls unlike on a liked proposal' do
        # put TODO
      end
    end
  end
end
