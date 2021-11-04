# frozen_string_literal: true

require 'rails_helper'

describe ProposalsHelper, type: :helper do
    before do
        @proposal = create(:proposal)
      end

    describe '#display_likes' do
        it 'displays likes' do
            expect(helper.display_likes(@proposal)).to include "Like"
        end
    end

    describe '#stats_card' do
        it 'displays a stats card' do
            expect(helper.stats_card(@proposal.title, @proposal.abstract)).to include @proposal.title
        end
    end

    # describe '#format_icon' do
    #     expect(helper.format_icon('NDSA Working Group Meeting')).to include 'hand-spock'
    # end
end