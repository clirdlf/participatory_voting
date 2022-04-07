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

    describe '#format_icon' do
        it 'displays a formatted icon' do
            expect(format_icon('90-minute Workshop')).to include 'handshake-angle'
            expect(format_icon('NDSA Working Group Meeting')).to include 'users'
            expect(format_icon('15-minute Presentation')).to include 'user'
            expect(format_icon('Snapshot')).to include 'camera'
            expect(format_icon('Panel')).to include 'users'
            expect(format_icon('Dork Shorts')).to include 'hand-spock'
            expect(format_icon('Workshop')).to include 'map-pin'
            expect(format_icon('15-minute Talk/Demo')).to include 'desktop'
            expect(format_icon('10-15-minute Tutorial')).to include 'handshake-angle'
            expect(format_icon('45-minute Workshop')).to include 'handshake-angle'
            expect(format_icon('Poster')).to include 'map'
            expect(format_icon('Hands-on Workshop')).to include 'handshake-angle'
            expect(format_icon('5-minute Lightning Talk')).to include 'bolt'
            expect(format_icon('Solution Room')).to include 'house-user'
            expect(format_icon('6:2:1 Lightning Talk')).to include 'bolt'
            expect(format_icon('Lunchtime Working Session')).to include 'flask'
            expect(format_icon('25-minute Birds of a Feather (BOAF) Session')).to include 'feather'
            expect(format_icon('foo')).to include 'user'
        end
    end
end