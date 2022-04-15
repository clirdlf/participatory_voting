# frozen_string_literal: true

##
# Helpers for Proposal
module ProposalsHelper
  ##
  # Display formatted likes
  #
  # @param proposal Proposal to display likes for
  # @return Formatted HTML (heart icon with number of votes)
  def display_likes(proposal)
    '<span class="fas fa-heart red"></span> '.html_safe + \
      pluralize(proposal.cached_votes_score, 'Like')
  end

  ##
  # Wrapper for displaying statistics about the voting
  #
  # @param title Title to use on the card
  # @param text Text to use on the card
  # @return String formatted HTML Boostrap card
  def stats_card(title, text)
    "<div class='card'>
      <div class='card-body'>
        <h5 class='card-title'>
          #{title}
        </h5>
        <p class='card-text'>#{text}</p>
      </div>
    </div>".html_safe
  end

  ##
  # Map icons to the formats
  #
  # @param format Format from data
  # @return String HTML string of FontAwesome icon
  def format_icon(format)
    "<span class='fa-solid fa-#{parse_format(format)}' aria-hidden='true'></span>".html_safe
  end
end

##
# Map icons to the formats
#
# @param format Session format from dataset
# @return String icon name to use for font-awesome
def parse_format(format)
  format_map = {
    'NDSA Working Group Meeting': 'users',
    'Panel': 'users',
    '45-minute Panel': 'users',
    'Snapshot': 'camera',
    'Dork Shorts': 'hand-spock',
    '10-15-minute Tutorial': 'handshake-angle',
    'Workshop': 'handshake-angle',
    'Hands-on Workshop': 'handshake-angle',
    '45-minute Workshop': 'handshake-angle',
    '90-minute Workshop': 'handshake-angle',
    'Three-hour Workshop': 'handshake-angle',
    'Poster': 'map',
    '5-minute Lightning Talk': 'bolt',
    '2-minute Lightning Talk/Poster': 'bolt',
    '6:2:1 Lightning Talk': 'bolt',
    '25-minute Birds of a Feather (BOAF) Session': 'feather',
    'Solution Room': 'house-user',
    'Lunchtime Working Session': 'pot-food'
  }

  # Anything with Presentation should return user

  return 'user' unless format_map.key?(format.to_sym)

  format_map[format.to_sym]
end
